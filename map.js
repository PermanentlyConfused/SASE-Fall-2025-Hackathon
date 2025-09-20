var currentLoc = L.marker([44.6698, -74.9813]).bindPopup("This is CurrentLoc");
var slcArts = L.marker([44.6698599, -74.9901593]).bindPopup("This is SLC Arts");
var Jernomnom = L.marker([44.6680167, -74.9908803]).bindPopup(
  "This is Jernomnom"
);
var indiaGrill = L.marker([44.6688102, -74.9864899]).bindPopup(
  "This is Indian Grill"
);
var Arts = L.layerGroup([slcArts]);
var Restaurant = L.layerGroup([indiaGrill]);
var Coffee = L.layerGroup([Jernomnom]);
var Events = L.layerGroup([Jernomnom]);

osmMap = L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
  maxZoom: 19,
  attribution:
    '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
});
var baseMaps = {
  OpenStreetMap: osmMap,
};
var overlayMaps = {
  Arts: Arts,
  Restaurant: Restaurant,
  Coffee: Coffee,
  Events: Events,
};
const map = L.map("map", {
  center: [44.6698, -74.9813],
  zoom: 16,
  layers: [osmMap, Arts, Restaurant, Coffee, Events],
});
LocMarker = L.marker([44.6698, -74.9813], {
  title: "Current Location",
  color: "blue",
}).addTo(map);
var layerControl = L.control.layers(baseMaps, overlayMaps).addTo(map);
