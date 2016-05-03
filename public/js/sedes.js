var map = L.map('map').setView([-34.9058707, -56.2001407], 15);

L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

var myIcon = L.icon({
  iconUrl: './img/maps/pinactive.svg',
  iconSize: [78, 104],
  iconAnchor: [40, 102],
  popupAnchor: [-16, -29]
});

// Radisson
var radisson = L.marker(
  [-34.90592,-56.19947],
  {
    icon: myIcon,
    title: "Radisson Victoria Plaza",
    alt: "Radisson Victoria Plaza"
  }).addTo(map);

radisson.addEventListener('click', function(){
  var radisson = document.getElementById('radisson');
  if ( (radisson.style.display == 'none') || (radisson.style.display != 'inline-block') ){
    radisson.style.display = 'inline-block';
  }else{
    radisson.style.display = 'none';
  }
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
  var maua = document.getElementById('maua');
  if ( (maua.style.display == 'none') || (maua.style.display != 'inline-block') ){
    maua.style.display = 'inline-block';
  }else{
    maua.style.display = 'none';
  }
});

document.getElementById('close_maua').addEventListener('click', function(){
  document.getElementById('maua').style.display = 'none';
});

document.getElementById('close_radisson').addEventListener('click', function(){
  document.getElementById('radisson').style.display = 'none';
});
