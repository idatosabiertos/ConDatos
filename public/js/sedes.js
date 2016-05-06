var map = L.map('map').setView([-34.9058707, -56.2001407], 15);

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
  [-34.9058709, -56.1995317],
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

// Casona Mauá
var casona = L.marker(
  [-34.9038875, -56.2042725],
  {
    icon: normal_pin,
    title: "Casona Mauá",
    alt: "Casona Mauá"
  }).addTo(map);

casona.addEventListener('click', function(){
  var maua = document.getElementById('maua');
  if (maua.classList.contains('unhide') ){
    document.getElementById('radisson').classList.remove('unhide');
    maua.classList.remove('unhide');
    casona.setIcon(normal_pin);
  } else {
    maua.classList.add('unhide');
    document.getElementById('radisson').classList.remove('unhide');
    radisson_marker.setIcon(normal_pin);
    casona.setIcon(active_pin);
  }
});

document.getElementById('close_maua').addEventListener('click', function(){
  document.getElementById('maua').classList.remove('unhide');
  casona.setIcon(normal_pin);
});

document.getElementById('close_radisson').addEventListener('click', function(){
  document.getElementById('radisson').classList.remove('unhide');
  radisson_marker.setIcon(normal_pin);
});
