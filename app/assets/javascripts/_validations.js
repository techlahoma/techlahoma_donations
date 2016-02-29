var Techlahoma = Techlahoma || {};

Techlahoma.Validations = {};

Techlahoma.Validations.validateField = function(selector, validator){
  console.log('selector ',selector);
  var field = $(selector);
  console.log('val ', field.val());
  var valid = validator(field.val());
  if(valid){
    field.removeClass('error');
  }else{
    field.addClass('error');
  }
  return valid;
}

Techlahoma.Validations.validatePresence = function(value){
  return value !== '' && typeof value !== 'undefined';
}

Techlahoma.Validations.validateEmail = function(email){
  return email.indexOf('@') > 0 && email.length > 5;
};
