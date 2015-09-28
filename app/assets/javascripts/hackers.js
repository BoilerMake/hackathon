$(document).ready(function(){
    //for loading values from db
    var loaded_option = $('#hacker_application_attributes_job_interest').val();
    if (loaded_option == 'not interested' || loaded_option == '') {
        $(".job-dates").hide();
    } else {
        $(".job-dates").show();
    }
    //for changing
    $('#hacker_application_attributes_job_interest').on('change', function() {
      if ( this.value == 'not interested') {
        $(".job-dates").hide();
      } else {
        $(".job-dates").show();
      }
    });

    window.setTimeout(function() {
      $('.alert').not('.file_alert').slideUp(250);
    }, 2000);

    $("#confirm_button").on("click", function(e){
      $("#hacker_confirmed").val(true);

      $(".edit_hacker").submit();
      e.preventDefault();
    });

    $("#decline_button").on("click", function(e){
      $("#hacker_declined").val(true);

      $(".edit_hacker").submit();
      e.preventDefault();
      return false;
    });
});
