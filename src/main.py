import os 
import json

response = os.popen('curl -s ipinfo.io').read()

data = json.loads(response)

print("City:", data.get('city'))
print("Region:", data.get('region'))
print("Country:", data.get('country'))
print("Location (lat,long):", data.get('loc'))