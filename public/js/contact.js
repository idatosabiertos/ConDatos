var button = document.getElementById("send");
button.addEventListener('click', function(e){
  e.preventDefault();
  var form = document.getElementById('contact');
  form.submit();
});
