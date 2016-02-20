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
      field = document.getElementById(error.id);
      field.className += ' error';
      field.scrollIntoView();
    });
  }
});
