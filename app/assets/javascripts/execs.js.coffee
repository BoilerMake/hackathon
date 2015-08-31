# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ajax:success", "form", (xhr, data, response) ->
  console.log(data)
  console.log(response)
  $('.rank-response').append '<h5>'+response+'</h5>'