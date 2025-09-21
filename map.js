var AttractionList = [];
var RestaurantList = [];
var EventsList = [];

async function loadEvents() {
  try {
    const response = await fetch("http://127.0.0.1:8081/Events");
    const data = await response.json();
    const attractionIcon = L.icon({
      iconUrl: "https://maps.google.com/mapfiles/ms/icons/blue-dot.png",
      iconSize: [32, 32],
      iconAnchor: [16, 32],
      popupAnchor: [0, -32],
    });

    const restaurantIcon = L.icon({
      iconUrl: "https://maps.google.com/mapfiles/ms/icons/green-dot.png",
      iconSize: [32, 32],
      iconAnchor: [16, 32],
      popupAnchor: [0, -32],
    });

    const eventIcon = L.icon({
      iconUrl: "https://maps.google.com/mapfiles/ms/icons/red-dot.png",
      iconSize: [32, 32],
      iconAnchor: [16, 32],
      popupAnchor: [0, -32],
    });

    for (let i = 0; i < data.payload.length; i++) {
      const item = data.payload[i];
      const lat = parseFloat(item.Lat);
      const lng = parseFloat(item.Long);
      const description = item.Description;
      const category = item.Category.toLowerCase();

      switch (category) {
        case "foods":
          RestaurantList.push(
            L.marker([lat, lng], { icon: restaurantIcon }).bindPopup(
              `Food: ${description}`
            )
          );
          break;
        case "attractions":
          AttractionList.push(
            L.marker([lat, lng], { icon: attractionIcon }).bindPopup(
              `Attraction: ${description}`
            )
          );
          break;
        case "events":
          EventsList.push(
            L.marker([lat, lng], { icon: eventIcon }).bindPopup(
              `Event!: ${description}`
            )
          );
          break;
        default:
          console.warn(`Unknown category: ${item.Category}`);
      }
    }
  } catch (error) {
    console.error("Error fetching events:", error);
  }
}

// ✳️ Modify to just return location (no need for map yet)
async function getCurrentLocation() {
  try {
    const response = await fetch("http://127.0.0.1:8081/currentLoc");
    const data = await response.json();
    if (data.payload.length > 0) {
      const item = data.payload[0]; // assuming only one location
      return {
        lat: parseFloat(item.Lat),
        lng: parseFloat(item.Long),
      };
    } else {
      throw new Error("No location data received.");
    }
  } catch (error) {
    console.error("Error fetching current location:", error);
    // fallback coordinates
    return { lat: 44.6698, lng: -74.9813 };
  }
}

async function initMapAndData() {
  try {
    const currentLoc = await getCurrentLocation();

    const osmMap = L.tileLayer(
      "https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
      {
        maxZoom: 15,
        attribution:
          '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
      }
    );

    const map = L.map("map", {
      center: [currentLoc.lat, currentLoc.lng],
      zoom: 19,
      layers: [osmMap],
    });

    L.marker([currentLoc.lat, currentLoc.lng], {
      title: "Current Location",
    }).addTo(map);

    await loadEvents();

    // Create and add layers
    const Attractions = L.layerGroup(AttractionList);
    const Restaurants = L.layerGroup(RestaurantList);
    const Events = L.layerGroup(EventsList);

    Attractions.addTo(map);
    Restaurants.addTo(map);
    Events.addTo(map);

    const baseMaps = {
      OpenStreetMap: osmMap,
    };

    const overlayMaps = {
      Attractions: Attractions,
      Restaurants: Restaurants,
      Events: Events,
    };

    L.control.layers(baseMaps, overlayMaps).addTo(map);

    console.log("Map and data loaded successfully.");
  } catch (error) {
    console.error("Error initializing map:", error);
  }
}

initMapAndData();
