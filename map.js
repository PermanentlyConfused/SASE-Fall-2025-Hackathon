var AttractionList = [];
var RestaurantList = [];
var EventsList = [];
async function loadEvents() {
  try {
    const response = await fetch("http://127.0.0.1:8080/Events");
    const data = await response.json();

    for (let i = 0; i < data.payload.length; i++) {
      const item = data.payload[i];
      const lat = parseFloat(item.Lat);
      const lng = parseFloat(item.Long);
      const description = item.Description;
      const category = item.Category.toLowerCase();

      switch (category) {
        case "foods":
          RestaurantList.push(
            L.marker([lat, lng]).bindPopup(`This is ${description}`)
          );
          break;
        case "attractions":
          AttractionList.push(
            L.marker([lat, lng]).bindPopup(`This is ${description}`)
          );
          break;
        case "events":
          // EventsList.push(
          //   L.marker([lat, lng]).bindPopup(`This is ${description}`)
          // );
          break;
        default:
          console.warn(`Unknown category: ${item.Category}`);
      }
    }
  } catch (error) {
    console.error("Error fetching events:", error);
  }
}

// Call the function and wait for it to finish
loadEvents().then(() => {
  console.log("Events loaded successfully.");
  var Attractions = L.layerGroup(AttractionList);
  var Restaurants = L.layerGroup(RestaurantList);
  var Events = L.layerGroup(EventsList);

  osmMap = L.tileLayer(
    "https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
    {
      maxZoom: 19,
      attribution:
        '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    }
  );
  var baseMaps = {
    OpenStreetMap: osmMap,
  };
  var overlayMaps = {
    Attractions: Attractions,
    Restaurants: Restaurants,
    Events: Events,
  };
  const map = L.map("map", {
    center: [44.6698, -74.9813],
    zoom: 16,
    layers: [osmMap, Attractions, Restaurants, Events],
  });
  LocMarker = L.marker([44.6698, -74.9813], {
    title: "Current Location",
    color: "blue",
  }).addTo(map);

  var layerControl = L.control.layers(baseMaps, overlayMaps).addTo(map);
});
