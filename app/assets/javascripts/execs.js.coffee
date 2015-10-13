# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ajax:success", "#hacker_ranking", (xhr, data, response) ->
  console.log(data)
  console.log(response)
  $('.rank-response').append '<h5>'+response+'</h5>'
  window.location.replace '/execs/ranker'

$(document).on 'ajax:success', '#user_query', (xhr, data, response) ->
  $('.results').empty()

  data.forEach (result) ->
    list_item = $("<div class='result' data-hacker_email='#{result.email}'>")
    list_item.append $("<h3 class='name'> #{result.first_name} #{result.last_name} </h3>")
    list_item.append $("<p> School: #{result.school_name}
                            <br>
                            Email: #{result.email}
                            <br>
                            Checked in Time: <span class='checked_in_time'>#{result.checked_in_time}</span>
                            <br>
                            Status?: #{result.status}
                            <br>
                            Confirmed?: #{if result.confirmed then "YES" else "NO"}
                            <br>
                            Declined?: #{if result.declined then "YES" else "NO"}
                            </p>")

    checkin_form = $("<form data-type='json' class='hacker-checkin' action='/execs/checkin' data-remote='true' method='post'>")
    checkin_form.append("<input type='hidden' name='checkin_token' value=#{checkin_token}>")
    checkin_form.append("<input type='hidden' name='email' value=#{result.email}>")
    checkin_form.append('<input type="submit" name="commit" value="Check In">')

    list_item.append checkin_form
    $('.results').append list_item

  $('#user_query').trigger("reset")

# on sucessful checkin, update the checked_in time for current hacker
# and hide the checkin button
$(document).on 'ajax:success', '.hacker-checkin', (xhr, data, response) ->
  result = $(".result[data-hacker_email='#{data.json.email}']")
  result.find('span.checked_in_time').html(data.json.checked_in_time)
  result.find('span.checked_in_time').stop().css('background-color', '#F69C55')
    .animate({ backgroundColor: '#FFFFFF'}, 500)
  result.find('input[type="submit"]').hide()

$(document).on "click", "#bad_ranking", (e) ->
  $("#ranking_field").val '1'
  $("#new_hacker_ranking").submit()

$(document).on "click", "#meh_ranking", (e) ->
  $("#ranking_field").val '2'
  $("#new_hacker_ranking").submit()

$(document).on "click", "#good_ranking", (e) ->
  $("#ranking_field").val '3'
  $("#new_hacker_ranking").submit()
