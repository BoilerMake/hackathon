$(document).ready(function(){
    var loaded_option = $('#hacker_application_attributes_job_interest').val();
    if ( loaded_option == 'not interested')
    {
        $(".job-dates").hide();
    }
    else
    {
        $(".job-dates").show();
    }

    $('#hacker_application_attributes_job_interest').on('change', function() {
      if ( this.value == 'not interested') {
        $(".job-dates").hide();
      } else {
        $(".job-dates").show();
      }
    });
});