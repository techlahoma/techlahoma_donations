// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var Techlahoma = Techlahoma || {};

Techlahoma.Sponsorships = {};

Techlahoma.Sponsorships.origButtonText = '';


$(function() {
  if( $('#new_sponsorship').length > 0 ){
    Techlahoma.Sponsorships.init();
  }
});


Techlahoma.Sponsorships.init = function(){

  Techlahoma.Stripe.init();

  Techlahoma.Stripe.initCardFormElements();

  $('form').submit(Techlahoma.Sponsorships.formHandler);
}

Techlahoma.Sponsorships.formHandler = function(event) {

  return Techlahoma.Stripe.formHandler(event,Techlahoma.Sponsorships.preValidate);

}

Techlahoma.Sponsorships.preValidate = function(){
  var $form = $('form');

  var formIsValid = true;
  var validateField = Techlahoma.Validations.validateField;
  var validatePresence = Techlahoma.Validations.validatePresence;

  formIsValid = validateField('input#sponsorship_name',validatePresence) && formIsValid;

  formIsValid = validateField('input.email',Techlahoma.Validations.validateEmail) && formIsValid;

  formIsValid = validateField('input.card-number',$.payment.validateCardNumber) && formIsValid;

  // This one is a little tricky, so we do it manually
  var ccExpField = $form.find('input.exp-date');
  var ccExpVal = $.payment.cardExpiryVal(ccExpField.val());
  var ccExpValid = $.payment.validateCardExpiry(ccExpVal.month,ccExpVal.year);
  if(ccExpValid){
    ccExpField.removeClass('error');
  }else{
    ccExpField.addClass('error');
  }

  formIsValid = validateField('input.cvc',$.payment.validateCardCVC) && formIsValid;

  return formIsValid;
};
