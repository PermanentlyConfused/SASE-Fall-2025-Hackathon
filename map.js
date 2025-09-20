var currentLoc = L.marker([44.6698, -74.9813]).bindPopup("This is CurrentLoc");
var slcArts = L.marker([44.6698599, -74.9901593]).bindPopup("This is SLC Arts");
var Jernomnom = L.marker([4.667987, -74.988479]).bindPopup("This is Jernomnom");
var indiaGrill = L.marker([44.6688102, -74.9864899]).bindPopup(
  "This is Indian Grill"
);

var Attractions = L.layerGroup([slcArts]);
var Restaurants = L.layerGroup([indiaGrill, Jernomnom]);
var Events = L.layerGroup([Jernomnom]);

osmMap = L.tileLayer("https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png", {
  maxZoom: 19,
  attribution:
    '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
});
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
