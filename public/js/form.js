var validator = new FormValidator('form', [{
  name: 'name',
  rules: 'required'
},{
  name: 'organization',
  rules: 'required'
},{
  name: 'email',
  rules: 'required'
},{
  name: 'email_organization',
  rules: 'required'
},{
  name: 'register_image',
  rules: 'required'
},{
  name: 'unconference_give',
  rules: 'maxlength[300]'
}], function(errors, event) {
  if (errors.length > 0) {
    errors.forEach(function(error){
      field = document.getElementById(error.id + "_wrap");
      field.style.backgroundColor = "#ffaaaa";
    });
  }
});

var interests = document.getElementById('interests');
interests.addEventListener('change', function(event){
  var selected = this.querySelectorAll("option:checked");
  if (selected.length > 3){
    selected[0].selected = false;
  }
});
