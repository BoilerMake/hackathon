/*global $:false */

var showForm = function(id) {
  $(id).fadeIn(250);
};
var hideForm = function(id) {
  $('.full-form').fadeOut(250);
};

$(document).ready(function(){
  $("#new_interest_signup").on('ajax:success', function(e, data, status, xhr){
    console.log(data);
  }).on('ajax:error', function(e, data, status, error){
    console.log(error);
  });
});
