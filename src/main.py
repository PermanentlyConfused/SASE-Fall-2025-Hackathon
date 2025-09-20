from src.SerialGPS import read_serial_data
from dotenv import load_dotenv
import os
import urllib.request
import json
import psycopg2

#! This is only locally hosted so it is fine-- Probably 
conn = psycopg2.connect(
    dbname="home_db",
    user="postgres",
    password="Mlpnkobji123",
    host="localhost",
    port="5432"
)

def updateHomeProfile()->int:
    """ Returns: 0(Updated HomeProfile), 1(Duplicate,No Change), 2(Error)
    """
    load_dotenv()
    currentLocation = read_serial_data('COM7', 9600) #Format [Lat,Lon]

    WEATHER_API_KEY = os.getenv('WEATHER_API_KEY')
    url = f"http://api.openweathermap.org/geo/1.0/reverse?lat={currentLocation[0]}&lon={currentLocation[1]}&limit=1&appid={WEATHER_API_KEY}"
    
    with urllib.request.urlopen(url) as response:
        raw_data = response.read()
        data = json.loads(raw_data.decode())

    country = data[0]['country']
    city = data[0]['name']
    state = data[0]['state']
    try:
        cur = conn.cursor()
        cur.execute("""
            INSERT INTO HomeProfile (Country, StateProvince, Town, Color, Lat, Long)
            VALUES (%s, %s, %s, %s, %s, %s)
            ON CONFLICT (Town) DO UPDATE
                SET Town = EXCLUDED.Town
            RETURNING xmax = 0;
        """, (country, state, city, 'white', currentLocation[0], currentLocation[1]))

        was_inserted = cur.fetchone()[0]

        if not was_inserted:
            raise ValueError(f"Conflict: Town '{city}' already exists in the database.")
        conn.commit()
        rVal = 0
    except ValueError as e:
        print("Custom Conflict Exception:", e)
        conn.rollback()
        rVal = 1
    except Exception as e:
        print("Error:", e)
        conn.rollback()
        rVal = 2
    finally:
        cur.close()
        conn.close()
    return rVal
    
    
updateHomeProfile()

