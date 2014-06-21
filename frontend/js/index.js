var inputBox = 0;

function validateEmail() {

}

function validatePassword() {

}

function submitForm() {

}



$(document).ready(function() {

    // EARLYBIRD APPLICATION BUTTON
    $("#register").click(function(event) {
        $(this).fadeOut("fast", function() {
            $("#email").fadeIn("fast", function() {
                $("#email input").focus();
            });
            inputBox += 1;
        });
    });

    // BACK BUTTONS
    $("#email .back").click(function(event) {
        $("#email").fadeOut("fast", function() {
            $("#register").fadeIn("fast");
            inputBox -= 1;
        });
    });
    $("#password .back").click(function(event) {
        $("#password").fadeOut("fast", function() {
            $("#email").fadeIn("fast");
            inputBox -= 1;
        });
    });
    $("#confirm-password .back").click(function(event) {
        $("#confirm-password").fadeOut("fast", function() {
            $("#password").fadeIn("fast");
            inputBox -= 1;
        });
    });

    // ENTER KEY FUNCTIONALITY
    $(".input").keypress(function(e) {
        if (e.which == 13) {
            if (inputBox === 1) {
                var isValidEmail = validateEmail();
                $("#email").fadeOut("fast", function() {
                    $("#password").fadeIn("fast", function() {
                        $("#password input").focus();
                    });
                    inputBox += 1;
                });
            } else if (inputBox === 2) {
                $("#password").fadeOut("fast", function() {
                    $("#confirm-password").fadeIn("fast", function() {
                        $("#confirm-password input").focus();
                    });
                    inputBox += 1;
                });
            } else if (inputBox === 3) {
                var isValidPassword = validatePassword();
                submitForm();
                inputBox += 1;
            }
        }
    });
});