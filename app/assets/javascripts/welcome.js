/*global $:false */
var inputBox = false;
var player;

function validateEmail() {
    var email = $("#email input").val();
    var atpos = email.indexOf("@");
    var dotpos = email.lastIndexOf(".");
    if (atpos < 1 || dotpos < atpos + 2) {
        return false;
    } else {
        return true;
    }
}

function validatePassword() {
    if ($("#password input").val().length < 6) {
        $("#password .error").html("Password must be at least 6 characters long.");
        return false;
    } else {
        return true;
    }
}

function validatePasswordsMatch() {
    var pass1 = $("#password input").val();
    var pass2 = $("#confirm-password input").val();
    if (pass1 !== pass2 || pass1 === "" || pass2 === "") {
        return false;
    } else {
        return true;
    }
}

function submitLogin() {
    $('#login-form').submit();
}
window.onYouTubePlayerAPIReady = function() {
  player = new YT.Player('player');
}

$(document).ready(function() {
  $('.text-box').masonry({
    itemSelector: '.text-box-container'
  });

  $('#basicModal').on('hidden.bs.modal', function (e) {
    console.log("hello world");
    player = new YT.Player('player');
    player.stopVideo();
  })

  window.addEventListener("scroll",function() {
    if(window.scrollY > 700) {
      $('.scrolling-header').slideDown();
    }
    else {
      $('.scrolling-header').slideUp();
    }
  }, false);

  $( ".mobile-button" ).click(function() {
    $( ".slide-down" ).slideToggle('fast');
  });

  $('.forgot-password-toggle').on('click', function(){
    $('.forgot-password').fadeToggle('fast');
  });

  $('.return').on('click', function(){
    $(".forgot-password").fadeOut("fast");
  })


  $('.login-toggle').on('click', function(){
    // a bit gross, but its a compromise between DRY and UI
    // defer till later if its visible because it gets pushed aside
    // by the form during the slideToggle and it looks strange
    var defer = false;
    if ( $("#login").is(':visible')){
      $('#login').toggle();
    } else {
      defer = true;
    }

    $('#login-form').slideToggle('slow', function(){
      if (defer){
        $('#login').toggle();
      }
    });
  });

});
