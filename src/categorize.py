from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.prompts import ChatPromptTemplate
import logging
import os
import getpass
from dotenv import load_dotenv
import psycopg2

## Dynamically categorizes existing events based on events and hobbies in database.

# Set up logging
logger = logging.getLogger(__name__)
load_dotenv()
# Load API Keys
if not os.getenv("GOOGLE_API_KEY"):
    os.environ["GOOGLE_API_KEY"] = getpass.getpass("Enter API key for Google Gemini: ")

conn = psycopg2.connect(
    dbname="home_db",
    user="postgres",
    password="Mlpnkobji123",
    host="localhost",
    port="5432"
)

with conn.cursor() as c:
    c.execute("SELECT EventID, Description FROM Events")
    events = c.fetchall()
    c.execute("SELECT HobbyID, HobbyName FROM Hobbies")
    hobby = c.fetchall()
    
event_dict = {t[1]: t[0] for t in events}
hobby_dict = {t[1]: t[0] for t in hobby}
# Results is a list of tuples, parse like that:

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
