var map = L.map('map').setView([-34.9058707, -56.2001407], 15);

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

var myIcon = L.icon({
  iconUrl: './img/maps/pinicon.png',
  iconSize: [24, 25],
  iconAnchor: [26, 27],
  popupAnchor: [-16, -29],
  shadowUrl: './img/maps/marker-shadow.png',
  shadowAnchor: [24, 40]
});
// Radisson
var marker = L.marker(
  [-34.90592,-56.19947],
  {
    icon: myIcon,
    title: "Radisson Victoria Plaza",
    alt: "Radisson Victoria Plaza"
  }).addTo(map);

marker.addEventListener('click', function(){
  // TODO : Mostrar info a la izquierda
  alert("TODO : Mostrar info a la izquierda");
});

// Casona Mauá
var casona = L.marker(
  [-34.90388,-56.20434],
  {
    icon: myIcon,
    title: "Casona Mauá",
    alt: "Casona Mauá"
  }).addTo(map);
casona.addEventListener('click', function(){
  // TODO : Mostrar info a la izquierda
});
