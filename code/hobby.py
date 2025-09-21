import csv
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.prompts import ChatPromptTemplate
import logging
import os
import getpass
from dotenv import load_dotenv

# Set up logging
logger = logging.getLogger(__name__)
load_dotenv()
# Load API Keys
if not os.getenv("GOOGLE_API_KEY"):
    os.environ["GOOGLE_API_KEY"] = getpass.getpass("Enter API key for Google Gemini: ")
# Read hobby categories
hobby_dict = {}
with open("hobby.csv", "r", encoding="utf-8") as file:
    content = csv.DictReader(file)
    for row in content:
        hobby_dict[row['name']] = int(row['id'])

# Read events from output file
with open("dbRequestOutput.txt", "r", encoding="utf-8") as file:
    content = file.read()

# Create event dictionary
event_dict = {}
for line in content.split("\n"):
    line = line.strip()
    if line and " | " in line:
        parts = line.split(" | ", 1)
        if len(parts) == 2:
            event_id = parts[0].strip()
            event_description = parts[1].strip()
            if event_id and event_description:
                event_dict[event_id] = event_description

# Initialize LLM
llm = ChatGoogleGenerativeAI(model="gemini-2.5-flash")

prompt = ChatPromptTemplate.from_messages([
    ("system", """You are a world-class expert at classifying local events into categories.
    Your sole purpose is to categorize an event description into the most appropriate categories.
    
    Available categories with their IDs:
    {categories_list}
    
    IMPORTANT: Return ONLY the category ID numbers separated by commas (e.g., "1,3,5").
    An event can belong to multiple categories. Choose ALL that apply.
    Do not return the category names, just the ID numbers.
    Do not add any explanation or additional text.
    """),
    ("human", "Event description: {event_description}\n\nReturn only the category ID numbers separated by commas:")
])

chain = prompt | llm

# Generate SQL INSERT statements
sql_statements = []

for event_id, event_description in event_dict.items():
    try:
        categories_list = "\n".join([f"{id}: {name}" for name, id in hobby_dict.items()])
        
        llm_output = chain.invoke({
            "categories_list": categories_list,
            "event_description": event_description
        })
        
        # Extract and parse multiple category IDs
        category_ids_str = llm_output.content.strip()
        category_ids = []
        
        # Parse comma-separated IDs
        for cat_id in category_ids_str.split(','):
            cat_id = cat_id.strip()
            if cat_id.isdigit():
                cat_id_int = int(cat_id)
                if cat_id_int in hobby_dict.values():
                    category_ids.append(cat_id_int)
        
        if category_ids:
            for category_id in category_ids:
                sql = f"INSERT INTO EventCat (EventID, HobbyID) VALUES ({event_id}, {category_id});"
                sql_statements.append(sql)
        else:
            pass
    except Exception as e:
        logger.error(f"Error processing event {event_id}: {e}")

# Output SQL statements
output = "\n".join(sql_statements)