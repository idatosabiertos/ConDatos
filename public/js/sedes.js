var map = L.map('map').setView([9.935743, -84.072618], 18);

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

var normal_pin = L.icon({
  iconUrl: './img/maps/pinnormal.svg',
  iconSize: [78, 104],
  iconAnchor: [40, 60],
  popupAnchor: [-16, -29]
});

var active_pin = L.icon({
  iconUrl: './img/maps/pinactive.svg',
  iconSize: [78, 104],
  iconAnchor: [40, 102],
  popupAnchor: [-16, -29]
});

// Radisson
var radisson_marker = L.marker(
  [9.935743, -84.072618],
  {
    icon: normal_pin,
    title: "Radisson Victoria Plaza",
    alt: "Radisson Victoria Plaza"
  }).addTo(map);

radisson_marker.addEventListener('click', function(){
  var radisson_info = document.getElementById('radisson');
  if (radisson_info.classList.contains('unhide') ){
    document.getElementById('maua').classList.remove('unhide');
    casona.setIcon(normal_pin);
    radisson_info.classList.remove('unhide');
    radisson_marker.setIcon(normal_pin);
  } else {
    radisson_info.classList.add('unhide');
    radisson_marker.setIcon(active_pin);
  }
});

document.getElementById('close_radisson').addEventListener('click', function(){
  document.getElementById('radisson').classList.remove('unhide');
  radisson_marker.setIcon(normal_pin);
});
