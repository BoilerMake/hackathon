$(function() {
	$('.js-s3_file_field').S3FileField({
      done: function(e, data) {
      	$("#hidden_resume").val(data.result.url);
      	$("#info").addClass("alert alert-success file_alert").fadeIn();
      	$(".js-s3_file_field").hide();
        // return console.log(data.result.url);
      }
     });
	$("#refresh").click(function(e) {
		$(".js-s3_file_field").fadeIn();
		$("#info").addClass("alert alert-success file_alert").hide();
		e.preventDefault();
	});
});