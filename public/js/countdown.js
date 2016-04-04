var countDown = function(theSelector, time){
  var output = "";
  var dTime = Date.parse(time);
  var theDate = Date.parse(new Date());
  var difference = dTime - theDate;
  var milliseconds = difference % 1000;

  function addZero(number){
    if(number <= 9){
      number = "0" + number;
    }
    return number;
  }

  x = difference / 1000;
  seconds = addZero(parseInt(x % 60));
  x /= 60;
  minutes = addZero(parseInt(x % 60));
  x /= 60;
  hours = addZero(parseInt(x % 24));
  x /= 24;
  days = addZero(parseInt(x));

  output += "<span class='days'>" + days + "<small>Días</small></span>";
  output += "<span class='hours'>" + hours + "<small>Horas</small></span>";
  output += "<span class='minutes'>" + minutes + "<small>Minutos</small></span>";
  output += "<span class='seconds'>" + seconds + "<small>Segundos</small></span>";
  document.querySelector(theSelector).innerHTML = output;
};


var Time = "7/11/2016 18:25:00";
setInterval(function(){
  countDown(".jcountTimer", Time);
}, 1000);
