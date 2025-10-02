import getpass
import os
from dotenv import load_dotenv
import logging
import json 

from typing import Dict, Optional
from langchain.prompts import ChatPromptTemplate
from langchain_core.tools import tool

from langchain_tavily import TavilySearch
from langchain_google_genai import ChatGoogleGenerativeAI

import re
import requests as r
from datetime import datetime

import sys
logger = logging.getLogger(__name__)


load_dotenv()

# Custom webscraping tool using gemini 2.0 flash
@tool
def eventsExtractor(content: str, 
                    date: str):
    """Takes the tavily results and a date to evaulate for valid events and organizes them into start/end date, location, and description"""
    llm = ChatGoogleGenerativeAI(model = "gemini-2.5-flash")
    systemMsg = f"""You are world-class expert at extracting information about events from online descriptions.
       Your sole purpose is to find details about an event from the provided text and return them in a structured string with ASCII encoding.
       Ignore all irrelevant information like navigation, ads, sidebars, sign in prompts.
       Focus on the main content on the page.
       
        You MUST return ONLY a valid string that has the following format where 'name', 'address', 'start date', 'end date' is defined as the following:
        format: INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'name', 'address', 'start date', 'end date', NULL, NULL);

        RULES:
        1. Create a separate INSERT statement for EACH distinct event
        2. If multiple events are found, separate them with newlines
        3. 'name': The name of the event. If there is a "'" character, replace it with "''"
        4. 'start date': The date of the event mentioned. Format it clearly with date and time
        5. If 'start date' is before {date}, ignore this event.
        6. 'end date': The date that the mentioned event ends. Format it clearly with date and time. If there is no ending date, put NULL in this field.
        7. 'address': The exact address including street number, street, town, state, zipcode. If no specific address, use the venue name and add " (unsure)" to the end. If there is no address at all, then skip this event
        8. Do NOT add any other text before or after the SQL statements
        9. If no events are found, return an empty string
       """
    prompt = ChatPromptTemplate.from_messages([
      ("system", systemMsg),
       ("human", "Extract the event details from the following text: \n\n {html}")
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
def searchEvents(location: str,
                 date: str,
                 hobby: str):

    if hobby != "":
        hobby = " that's "+ hobby 

    rq = f"events near {location} {hobby} within the next week starting from {date}"

    # Call search
    tool = TavilySearch(max_results=50, include_raw_content = True, time_range = 'week', search_depth = 'advanced', chunks_per_source = 2)
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
            output = output + "\n" + eventsExtractor.invoke({"content": tavilySearch, "date": date})
            tavilySearch = ""

    if i%chunk == 1:
        output = output + "\n"+ eventsExtractor.invoke({"content": tavilySearch, "date": date})
    return output

# Date time converter:
def convert_datetime_string(date_string: str) -> str:
    """
    Convert datetime string from format like "September 25, 2025 2:00 PM"
    to "YYYY-MM-DD HH:MM:SS" format.
    """
    try:
        # Parse the input string
        dt_object = datetime.strptime(date_string, "%B %d, %Y %I:%M %p")
        
        # Convert to the desired format
        return dt_object.strftime("%Y-%m-%d %H:%M:%S")
        
    except ValueError as e:
        return date_string

# google maps place finder
def googleMapsSearch(query: str) -> Optional[Dict]:
    """ 
    Search for a location using Google Places API Text Search.

    Returns a dictionary with:
    - "address": the street address of the place
    - "longitude": the longitude of the street address
    - "latitude": the latitude of the street address
    """
    load_dotenv()
    # Load API Keys
    try:
        api_key = os.getenv("GOOGLE_MAPS_API_KEY")
    except:
        os.environ["GOOGLE_MAPS_API_KEY"] = getpass.getpass("Enter API key for Google Places API: ")
        api_key = os.environ["GOOGLE_MAPS_API_KEY"]
    
    endpoint = "https://maps.googleapis.com/maps/api/place/textsearch/json?"

    params = {
        "query": f"{query}",
        "key": api_key
    }
    
    try:
        response = r.get(endpoint, params=params)
        data = response.json()
        
        if data.get("status") == "OK" and data.get("results"):
            # Return the first result
            place = data["results"][0]
            return {
                "name": place.get("name"),
                "address": place.get("formatted_address"),
                "place_id": place.get("place_id"),
                "location": place.get("geometry", {}).get("location"),
                "types": place.get("types", [])
            }
        else:
            print(f"API Error: {data.get('status')} - {data.get('error_message', 'No error message')}")
            return None
            
    except Exception as e:
        print(f"Error calling Places API: {e}")
        return None

# Split by ;
def processSQL(GeminiOutput: str):
    sqlStatements = [st.strip() for st in GeminiOutput.split(";") if st.strip()]

    # Remove all the insert statements:
    labels = ['type', 'desc', 'addr', 'star', 'end']
    addresses = []
    statementHead = r'INSERT INTO Events \(.*?\) VALUES \(\''
    tag = r' \(unsure\)'

    # For each insert statement
    for i in range(len(sqlStatements)):
        address = ""
        statement = sqlStatements[i]

        match = re.search(statementHead, statement)
        # If we find that string match, delete it then split it
        if match:
            values_str = statement.replace(match.group(), "") # delete here
            try:
                address = values_str.split("', '")[2] # parse here
            except Exception as e:
                print(f"{e}: Cannot parse string")
                print(values_str.split("', '")[2]) # parse here

            # It's guaranteed that the last element of the split is NULL, NULL which will not be split
            last = values_str.split("', '")[-1]
            timeStart = last.split(", ")[-2]
            timeEnd = last.split(", ")[-1]
            
            # datetimes:
            nStart = convert_datetime_string(timeStart)
            sqlStatements[i] = sqlStatements[i].replace(timeStart, nStart)
            nEnd = convert_datetime_string(timeEnd)
            sqlStatements[i] = sqlStatements[i].replace(timeEnd, nEnd)

            # check if gemini was unsure
            match2 = re.search(tag, address)
            if match2:
                # remove it
                address = address.replace(match2.group(), "")

        #result = {'location': {'lat': str(-1), 'lng': str(-2)}, 'address': "temp"}

        # Run to google maps to look up the places
        ### DO NOT RUN UNTIL READY!!!!!!
        result = googleMapsSearch(address)


        naddress = ""
        if result:
            nlat = str(result['location']['lat'])
            nlon = str(result['location']['lng'])
            naddress = result['address']
        else:
            print(f"Error finding {address} using api.")
            nlat = "NULL"
            nlon = "NULL"
            naddress = address
        
        # find address, replace with new address
        lonLatSearch = rf"{address}"
        match3 = re.search(lonLatSearch, statement)
        if match3:
            # Replace address
            sqlStatements[i] = sqlStatements[i].replace(address, naddress)
            # replace LATITUDE
            sqlStatements[i] = sqlStatements[i][:-11] + " " + nlat + sqlStatements[i][-6:]
            # replace LONGITUDE
            sqlStatements[i] = sqlStatements[i][:-5] + ", " + nlon + ");"

    output1 = "\n".join(sqlStatements)
    return output1
    
if __name__ == "__main__" or not (os.getenv("GOOGLE_API_KEY") and os.getenv("TAVILY_API_KEY")):
    # Load API Keys
    if not os.getenv("GOOGLE_API_KEY"):
        os.environ["GOOGLE_API_KEY"] = getpass.getpass("Enter API key for Google Gemini: ")

    if not os.getenv("TAVILY_API_KEY"):
        os.environ["TAVILY_API_KEY"] = getpass.getpass("Enter API key for Tavily Search: ")

    location, domain, hobby = "", "", ""
    if len(sys.argv) > 1:
        location = sys.argv[1]
        try:
            domain = sys.argv[2]
            hobby = sys.argv[3]
        except:
            domain = ""
            hobby = ""
            pass
        events = searchEvents(location= location, date = domain, hobby = hobby)
        print('Event search complete')
        eventsLocated = processSQL(events)
        with open("eventsPitt.txt", "w") as file:
            file.write(eventsLocated)
        print('Events done')
    else:
        print(f"Not enough args. Expected at least 1 args (location) but only received {len(sys.argv)-1}")
