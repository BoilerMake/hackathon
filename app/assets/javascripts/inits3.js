$(function() {
	$('.js-s3_file_field').S3FileField({
      done: function(e, data) {
        return console.log(data.result.url);
      }
     });
});