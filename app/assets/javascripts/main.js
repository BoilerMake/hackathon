$(function() {
  $('form.new_hacker').submit(function(event) {
    var form = $(this);
    $.ajax({
      type: form.attr('method'),
      url: form.attr('action'),
      data: form.serialize(),
      success: function (data) {
        var string = "";
        jQuery.each(data, function(i, val) {
          if(i == "success") {
            window.location.href = "/dashboard";
          }
          string += (i + " " + val);
        });
        $("#signup_alert").addClass("alert alert-danger").html(string + "<br/>").fadeIn();
      }
    });
    event.preventDefault(); // Prevent the form from submitting via the browser.
  });
});