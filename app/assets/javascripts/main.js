var showSignupForm = function() {
	$('#applyMeow').html('Register');
	$('#sponsorPlz').addClass('hidden');
	$('#cancelRightMeow').removeClass('hidden');
	$('#signupForm').addClass('opened')
	$('#signupFormEmail').focus();
};

var listeners = function() {
	var applyActive = false;
	$('#applyMeow').click(function(event) {
		if (!applyActive) {
			applyActive = true;
			showSignupForm();
		} else {
			$('#carton-1-1').animate({left: '-100vw'}, 250);
			$('#carton-1-2').animate({left: '0'}, 250);
			$('#crate-2').addClass('hidden');
		}
	});
	$('#cancelRightMeow').click(function(event) {
		if (applyActive) {
			applyActive = false;
			$('#signupForm').removeClass('opened')
			$('#cancelRightMeow').addClass('hidden');
			$('#sponsorPlz').removeClass('hidden');
			$('#applyMeow').html('Apply Now');
		}
	});
};

$('.orange-juice').ready(function() {
	listeners();
});