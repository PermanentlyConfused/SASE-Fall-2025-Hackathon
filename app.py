import requests
import json

LOCATIONIQ_API_KEY = "pk.12736cac0fd500b432e5a911400ce0b5"

def find_places_osm(location, place_type="restaurant", radius=1000):
    geocode_url = f"https://us1.locationiq.com/v1/search.php?key={LOCATIONIQ_API_KEY}&q={location}&format=json"

    try:
        resp = requests.get(geocode_url, timeout=10)
        if resp.status_code != 200:
            print("❌ Geocoding error:", resp.status_code)
            print("Response:", resp.text)
            return []
        data = resp.json()
    except Exception as e:
        print("⚠️ Failed to get geocoding data:", e)
        return []

    if not data:
        print("❌ Location not found.")
        return []

    lat = data[0]['lat']
    lon = data[0]['lon']

    overpass_url = "http://overpass-api.de/api/interpreter"
    query = f"""
    [out:json];
    node(around:{radius},{lat},{lon})[amenity={place_type}];
    out;
    """

    try:
        r = requests.get(overpass_url, params={'data': query}, timeout=15)
        if r.status_code != 200:
            print("❌ Overpass error:", r.status_code)
            print(r.text)
            return []
        results = r.json().get('elements', [])
    except Exception as e:
        print("⚠️ Failed to query Overpass API:", e)
        return []

    if not results:
        print("❌ No places found.")
        return []

    places = []
    for place in results:
        name = place['tags'].get('name', 'Unnamed')
        lat = place.get('lat')
        lon = place.get('lon')
        places.append({
            "name": name,
            "lat": lat,
            "lon": lon,
            "type": place_type
        })

        print(f"📍 {name} (Lat: {lat}, Lon: {lon})")


    return places

if __name__ == "__main__":
    city = input("Enter a city (e.g., Potsdam, New York): ")
    category = input("Enter place type (e.g., restaurant, cafe, park): ")

    found_places = find_places_osm(city, place_type=category)

    if found_places:
        with open("data.json", "w", encoding="utf-8") as f:
            json.dump(found_places, f, ensure_ascii=False, indent=2)
        print(f"\n✅ {len(found_places)} places saved to 'data.json'.")
