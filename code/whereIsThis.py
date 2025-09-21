import re
import os
import requests as r
from typing import Dict, Optional
from dotenv import load_dotenv
import getpass
from datetime import datetime

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
        os.environ["GOOGLE_MAPS_API_KEY"] = getpass.getpass("Enter API key for Google Gemini: ")
        api_key = os.environ["GOOGLE_MAPS_API_KEY"]
    
    endpoint = "https://maps.googleapis.com/maps/api/place/textsearch/json"

    params = {
        "query": query,
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

###
# Parser address finder companion
with open("output.txt", "r", encoding="utf-8") as file:
    content = file.read()

# Split by ;
sqlStatements = [st.strip() for st in content.split(";") if st.strip()]

# Remove all the insert statements:
labels = ['type', 'desc', 'addr', 'star', 'end']
addresses = []
statementHead = r'INSERT INTO Events \(.*?\) VALUES \(\''
tag = r' \(unsure\)'

# For each insert statement
for i in range(len(sqlStatements)):
    address = ""
    # remove newline:
    sqlStatements[i] = sqlStatements[i].replace("\n", "")
    statement = sqlStatements[i]

    match = re.search(statementHead, statement)
    # If we find that string match, delete it then split it
    if match:
        values_str = statement.replace(match.group(), "") # delete here
        address = values_str.split("', '")[2] # parse here

        # It's guaranteed that the last element of the split is NULL, NULL which will not be split
        last = values_str.split("', '")[-1]
        timeStart = last.split(", ")[-2]
        timeEnd = last.split(", ")[-1]
        
        # datetimes:
        nStart = convert_datetime_string(timeStart)
        sqlStatements[i] = sqlStatements[i].replace(timeStart, nStart)
        nEnd = convert_datetime_string(timeEnd)
        sqlStatements[i] = sqlStatements[i].replace(timeEnd, nStart)

        # check if gemini was unsure
        match2 = re.search(tag, address)
        if match2:
            # remove it
            address = address.replace(match2.group(), "")

    # run to google maps
    ### DO NOT RUN UNTIL READY!!!!!!
    result = googleMapsSearch(address)

    #result = {'location': {'lat': str(-1), 'lng': str(-2)}, 'address': "temp"}
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
    if match:

        # Replace address
        sqlStatements[i] = sqlStatements[i].replace(address, naddress)
        # replace LATITUDE
        sqlStatements[i] = sqlStatements[i][:-11] + " " + nlat + sqlStatements[i][-6:]
        # replace LONGITUDE
        sqlStatements[i] = sqlStatements[i][:-5] + " " + nlon + ");"

output = "\n".join(sqlStatements)
print(output)

