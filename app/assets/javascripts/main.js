var showSignupForm = function() {
	$('#signupForm').addClass('opened')
	$('#applySponsor').addClass('freshly-squeezed');
	// $('#sponsorPlz').addClass('hidden');
	$('#hacker_email').focus();
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
	$('#signupForm button').click(function(event) {
		if (applyActive) {
			applyActive = false;
			$('#signupForm').removeClass('opened')
			$('#applySponsor').removeClass('freshly-squeezed');
		}
	});
};

$('.orange-juice').ready(function() {
	listeners();
});