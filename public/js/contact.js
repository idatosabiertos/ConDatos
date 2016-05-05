var validator = new FormValidator('contact', [{
  name: 'name',
  rules: 'required'
},{
  name: 'organization',
  rules: 'required'
},{
  name: 'email',
  rules: 'required'
},{
  name: 'message',
  rules: 'required|min_length[20]'
},{
  name: 'country',
  rules: 'required|callback_check_country'
}], function(errors, event) {
  if (errors.length > 0) {
    errors.forEach(function(error){
      var field = document.getElementById(error.id);
      field.className += ' error';
    });
    var element = document.getElementById(errors[0].id);
    smoothScroll(element, 800);
  }
});

validator.registerCallback('check_country', function(value){
  if(value == 'País*' || value == '--------' || value == 'Country*'){
    return false;
  }
  return true;
}).setMessage('check_country', 'Por favor seleccione un país');
