from shapely.geometry import Point
from shapely import wkt
import pandas as pd
import psycopg2

file = '../utility/processed.csv'
utilities = pd.read_csv(file, low_memory=False)

def get_utility_ids_for_point(lat, lon, df, geom_col='the_geom', id_col='UtilID'):
    point = Point(lon, lat)
    utility_ids = []
    for idx, row in df.iterrows():
        try:
            multipolygon = wkt.loads(row[geom_col])
            if multipolygon.contains(point):
                utility_ids.append(str(row[id_col]))
        except:
            continue
    return utility_ids

def get_utilities_by_type_for_point(lat, lon, df, geom_col='the_geom'):
    point = Point(lon, lat)
    electric_ids = []
    gas_ids = []
    
    for idx, row in df.iterrows():
        try:
            multipolygon = wkt.loads(row[geom_col])
            if multipolygon.contains(point):
                if row['UtilityType'] == 'electric':
                    electric_ids.append(str(row['UtilID']))
                elif row['UtilityType'] == 'gas':
                    gas_ids.append(str(row['UtilID']))
        except:
            continue
    
    return electric_ids, gas_ids


# I need the HomeProfile's HomeID, Lat, Long
conn = psycopg2.connect(
    dbname="home_db",
    user="postgres",
    password="Mlpnkobji123",
    host="localhost",
    port="5432"
)
with conn.cursor() as c:
    c.execute("SELECT HomeID, Lat, Long FROM HomeProfile")
    events = c.fetchall()

test_points = []

for i in events:
    homeID, lat, long = i
    test_points = test_points.append((lat, long))
    
#test_points = [(44.6642656, -74.972129)]
#homeID = 1
results = []
for lat, lon in test_points:
    # Get utility IDs separated by type
    elec_utility_ids, gas_utility_ids = get_utilities_by_type_for_point(lat, lon, utilities)
    
    # Create one entry for each electric utility
    for util_id in elec_utility_ids:
        results.append({
            "Latitude": lat,
            "Longitude": lon,
            "UtilID": util_id,
            "UtilityType": "electric"
        })
    
    # Create one entry for each gas utility
    for util_id in gas_utility_ids:
        results.append({
            "Latitude": lat,
            "Longitude": lon,
            "UtilID": util_id,
            "UtilityType": "gas"
        })
    
    # If no utilities found, add one entry with "None"
    if not elec_utility_ids and not gas_utility_ids:
        results.append({
            "Latitude": lat,
            "Longitude": lon,
            "UtilID": "None",
            "UtilityType": "None"
        })
insert = "INSERT INTO HomeProfile_Utilities (HomeID, UtilID, Payment) VALUES"
sql = ""
for i in results:
    sql = sql+insert + f" ('{homeID}', '{i['UtilID']}', 'FALSE');\n"
print(sql)