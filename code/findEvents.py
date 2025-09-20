import getpass
import os
from dotenv import load_dotenv
import logging
import json 

from typing import Annotated
from typing_extensions import TypedDict
from langgraph.graph.message import add_messages

from langchain.prompts import ChatPromptTemplate
from langchain_core.tools import tool

from langchain_tavily import TavilySearch
from langchain_google_genai import ChatGoogleGenerativeAI

logger = logging.getLogger(__name__)


load_dotenv()
# Load API Keys
if not os.getenv("GOOGLE_API_KEY"):
    os.environ["GOOGLE_API_KEY"] = getpass.getpass("Enter API key for Google Gemini: ")

if not os.getenv("TAVILY_API_KEY"):
    os.environ["TAVILY_API_KEY"] = getpass.getpass("Enter API key for Tavily Search: ")

# Define state
class State(TypedDict):
  messages: Annotated[list, add_messages]
  sql: list

# Custom webscraping tool using gemini 2.0 flash
@tool
def eventsExtractor(content: str):
    """Takes the tavily results and organizes them into date, location, and description"""
    llm = ChatGoogleGenerativeAI(model = "gemini-2.5-flash")
    prompt = ChatPromptTemplate.from_messages([
      ("system", """You are world-class expert at extracting information about events from online descriptions.
       Your sole purpose is to find details about an event from the provided text and return them in a structured string.
       Ignore all irrelevant information like navigation, ads, sidebars, sign in prompts.
       Focus on the pain content on the page.
       
        You MUST return ONLY a valid string that has the following format where "name", "address", "date" is defined as the following:
        - "name": (string) The name of the event. If there is a "'" character, replace it with "''"
        - "date": (string) The date of the event mentioned in the html. Format it clearly.
        - "address": (string) The exact address of this location including street number, street, town, state, zipcode. If there is not a specific address, search up the venue name using the website domain and the provided location information, then add" (unsure)" to the end.

        format: INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'name', 'address', 'start date', 'end date', NULL, NULL);

        RULES:
        1. Create a separate INSERT statement for EACH distinct event
        2. If multiple events are found, separate them with newlines
        3. 'name': The name of the event
        4. 'start date': The date of the event mentioned. Format it clearly with date and time
        5. 'end date': The date that the mentioned event ends. Format it clearly with date and time. If there is no ending date, put NULL in this field.
        5. 'address': The exact address including street number, street, town, state, zipcode. 
          If no specific address, use the venue name and add " (unsure)" to the end.
        6. Do NOT add any other text before or after the SQL statements
        7. If no events are found, return an empty string
       """),
       ("human", "Extract the event details from the following HTML: \n\n {html}")
   ])

    chain = prompt | llm

    try:
        llm_output = chain.invoke({"html": content})
        event = llm_output.content
        return event

    except json.JSONDecodeError as e:
        logger.error(f"LLM returned invalid string. Error: {e}")
        return e
    except Exception as e:
        logger.error(f"Error parsing HTML with LLM: {e}")
        return e

# Tavily search
search = TavilySearch(max_results=2, include_raw_content = True, time_range = 'week')

# Search query
location = "potsdam ny"
domain = None
rq = f"events near {location} {domain} within the next week"

# Call search
tool = TavilySearch(max_results=25, include_raw_content = True, time_range = 'week', search_depth = 'advanced', chunks_per_source = 2)
tool_msg = tool.invoke({"query": rq})
tavilySearch = ""


# process search
i = 0
chunk = 2
output = ""
for result in tool_msg['results']:
    i += 1
    tavilySearch = tavilySearch + '\n' + result['content']
    if i % chunk == 0:
        # Call the tool directly
        output = output + "\n" + eventsExtractor(tavilySearch)
        tavilySearch = ""

if i%chunk == 1:
    output = output + "\n"+ eventsExtractor(tavilySearch)

print(output)
