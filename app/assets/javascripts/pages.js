$(document).ready(function(){
	$("#scrollBtn").click(function() {
  		$('html, body').animate({
        	scrollTop: $('#about').offset().top
    	}, 500);
    	return false;
	});
});