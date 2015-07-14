$(function() {
  $('.js-s3_file_field').S3FileField({
      done: function(e, data) {
        $("#hidden_resume").val(data.result.url);
        $("#info span").html("Upload Complete!");
        $('#save').attr('disabled', 'false');
        $("#info").removeClass("alert-info").addClass("alert-success");
      },
      add: function(e, data) {
        $('#save').attr('disabled', 'true');
        $(".js-s3_file_field").hide();
        $("#info").addClass("alert alert-info file_alert").fadeIn();
        data.submit();
      },
      progress: function(e, data){
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
