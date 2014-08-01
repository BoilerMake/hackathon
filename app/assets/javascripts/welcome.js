/*global $:false */
var inputBox = false;

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

function submitRegister() {
  $('#new_hacker').submit();
}

function submitLogin() {
  $('#login-form').submit();
}

$(document).ready(function() {

  $('.text-box').masonry({
    itemSelector: '.text-box-container'
  });


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



  $('.login-toggle').on('click', function(){
    // a bit gross, but its a compromise between DRY and UI
    // defer till later if its visible because it gets pushed aside
    // by the form during the slideToggle and it looks strange
    var defer = false
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

  $('.apply-toggle').on('click', function() {
    $('#apply-here').toggle();
    $('#signup-form').slideToggle('slow');
  });


  // EARLYBIRD APPLICATION BUTTON
  $("#register").click(function() {
    $('body,html').animate({
      scrollTop: 2000
    }, 800);
    $(this).fadeOut("fast", function() {
      $("#email").fadeIn("fast", function() {
        $("#email input").focus();
      });
      $("#password").fadeIn("fast");
      $("#confirm-password").fadeIn("fast");
      $("#apply-submit").fadeIn("fast");
      inputBox = true;
    });
  });

  // ENTER KEY FUNCTIONALITY
  $('#login-form').keypress(function(e) {
    if (e.which === 13) {
      e.preventDefault();
      if (inputBox) {
        submitLogin();
      } else {
        inputBox = true;
      }
    }
  });

  // ENTER KEY FUNCTIONALITY
  $('#new_hacker').keypress(function(e) {
    if (e.which === 13) {
      e.preventDefault();
      if (inputBox) {
        var isEmailValid = validateEmail();
        var isPasswordValid = validatePassword();
        var passwordsMatch = validatePasswordsMatch();
        if (isEmailValid) {
          $("#email .error").addClass('hidden');
          if (isPasswordValid) {
            $("#password .error").addClass('hidden');
            if (passwordsMatch) {
              $("#confirm-password .error").addClass('hidden');
              console.log("success");
              submitRegister();
            } else {
              // TODO display "Passwords do not match"
              $("#confirm-password .error").removeClass('hidden');
              $("#confirm-password input").focus();
            }
          } else {
            // TODO display "password must include at least 6..."
            $("#password .error").removeClass('hidden');
            $("#password input").focus();
          }
        } else {
          // TODO display "Invalid email, must be a .edu address"
          $("#email .error").removeClass('hidden');
          $("#email input").focus();
        }
      } else {
        $('body,html').animate({
          scrollTop: 460
        }, 800);
        $("#register").fadeOut("fast", function() {
          $("#email").fadeIn("fast", function() {
            $("#email input").focus();
          });
          $("#password").fadeIn("fast");
          $("#confirm-password").fadeIn("fast");
          inputBox = true;
        });
      }
    }
  });

});
