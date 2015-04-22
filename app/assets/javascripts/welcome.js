/*global $:false */

$(document).ready(function(){
  $("#new_interest_signup").on('ajax:success', function(e, data, status, xhr){
    $("#new_interest_signup").hide();
    $("#logo").append($("<h2>Thanks for signing up, " + data.email + "</h2>"));

    console.log(e);
    console.log(data);
    console.log(status);
    console.log(xhr);
  }).on('ajax:error', function(e, data, status, error){
    $("#new_interest_signup").hide();
    $("#logo").append($("<h2>OH NO!!!!</h2>"));

    console.log(e);
    console.log(data);
    console.log(status);
    console.log(error);
  });
});
