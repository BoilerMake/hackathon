$(function() {
  $('.js-s3_file_field').S3FileField({
      done: function(e, data) {
        $("#hidden_resume").val(data.result.url);
        $("#info").addClass("alert alert-success file_alert").fadeIn();
        $(".js-s3_file_field").hide();
        $('#save').attr('disabled', 'false');
      },
      add: function(e, data) {
        $('#save').attr('disabled', 'true');
        data.submit();
      },
      progress: function(e, data){
        $('form :submit').attr("disabled", "disabled");
        progress = parseInt(data.loaded / data.total * 100, 10);
        $("#info span").html("File " + progress + "% uploaded");
      }
     });
  $("#refresh").click(function(e) {
    $(".js-s3_file_field").fadeIn();
    $("#info").addClass("alert alert-success file_alert").hide();
    e.preventDefault();
  });
});
