import pandas as pd
from langchain_tavily import TavilySearch
import getpass
import os
from dotenv import load_dotenv
import re

load_dotenv()
if not os.environ.get("TAVILY_API_KEY"):
    os.environ["TAVILY_API_KEY"] = getpass.getpass("Tavily API key:\n")

electric_file = "../utility/NYS_Electric_Utility_Service_Territories_20250919.csv"
gas_file      = "../utility/NYS_Gas_Utility_Service_Territories_20250919.csv"

df_elec = pd.read_csv(electric_file, low_memory=False, dtype=str).fillna('NULL')
df_gas  = pd.read_csv(gas_file, low_memory=False, dtype=str).fillna('NULL')

# Replace string 'nan' with 'NULL' in both dataframes
df_elec = df_elec.replace('nan', 'NULL')
df_gas = df_gas.replace('nan', 'NULL')

# Select and rename columns for electric utilities
df_elec['UtilityType'] = 'electric'

# Select and rename columns for gas utilities
df_gas['UtilityType'] = 'gas'

# Join the two dataframes
df_combined = pd.concat([df_elec, df_gas], ignore_index=True)
df_combined['UtilID'] = range(1, len(df_combined) + 1)

# Comprehensive phone number pattern
pattern = r'''
    (?:\+?1\s*[-.\s]?)?      # optional country code (+1 or 1)
    \(?\d{3}\)?              # area code with optional parentheses
    [-.\s]?                  # optional separator
    \d{3}                    # first 3 digits
    [-.\s]?                  # optional separator
    \d{4}                    # last 4 digits
'''
df_combined['PhoneNumber'] = "NULL"
for i, r in df_combined.iterrows():
    # Use tavily search to find phone number:
    tool = TavilySearch(max_results=1, include_answer=True)
    try:
        utility = r['COMP_FULL'] + " ("+ r['COMP_SHORT']+")"
    except:
        print(r['COMP_FULL'])
        print(r['COMP_SHORT'])
    rq = f"What is {utility}'s phone number?"
    tool_msg = tool.invoke({"query": rq})
    phoneNum = tool_msg['answer']
    phone_numbers = re.findall(pattern, phoneNum, re.VERBOSE)
    phone_numbers = ", ".join(phone_numbers)
    df_combined.at[i, 'PhoneNumber'] = phone_numbers

# Generate SQL INSERT statements
insert = "INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES"

values = []
for _, row in df_combined.iterrows():
    # Handle NULL phone numbers and escape single quotes in company names
    company = str(row['COMP_FULL']).replace("'", "''")
    phone_number = f"'{row['PhoneNumber']}'" if row['PhoneNumber'] != "NULL" and row['PhoneNumber'] else 'NULL'
    utility_type = str(row['UtilityType'])
    values.append(f"{insert} ({row['UtilID']}, '{company}', {phone_number}, '{utility_type}')")

# Print all values joined by commas and newlines
sql = ";\n".join(values)
print(sql+";")

# save to csv:
df_combined.to_csv('../utility/processed.csv', index=False)
