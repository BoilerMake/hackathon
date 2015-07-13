$(function() {
	$('.js-s3_file_field').S3FileField({
      done: function(e, data) {
      	$("#hidden_resume").val(data.result.url);
      	$("#info").addClass("alert alert-success").fadeIn();
      	$(".js-s3_file_field").fadeOut();
        // return console.log(data.result.url);
      }
     });
	$("#refresh").click(function(e) {
		$(".js-s3_file_field").fadeIn();
		$("#info").addClass("alert alert-success").fadeOut();
		e.preventDefault();
	});
});