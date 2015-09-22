# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ajax:success", "form", (xhr, data, response) ->
  console.log(data)
  console.log(response)
  $('.rank-response').append '<h5>'+response+'</h5>'
  window.location.replace '/execs/ranker'

$(document).on "click", "#bad_ranking", (e) ->
  $("#ranking_field").val '1'
  $("#new_hacker_ranking").submit()

$(document).on "click", "#meh_ranking", (e) ->
  $("#ranking_field").val '2'
  $("#new_hacker_ranking").submit()

$(document).on "click", "#good_ranking", (e) ->
  $("#ranking_field").val '3'
  $("#new_hacker_ranking").submit()
