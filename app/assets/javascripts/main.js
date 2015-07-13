var showSignupForm = function() {
	$('#signupForm').css('display': 'block');
};

var hideSignupForm = function() {
	$('#signupForm').removeClass('opened')
	$('#applySponsor').removeClass('freshly-squeezed');
};

var showLoginForm = function() {
	$('#loginForm').addClass('opened')
	$('#applySponsor').addClass('freshly-squeezed');
	$('#alreadyRegistered').addClass('freshly-squeezed');
};

var hideLoginForm = function() {
	$('#loginForm').removeClass('opened')
	$('#applySponsor').removeClass('freshly-squeezed');
	$('#alreadyRegistered').removeClass('freshly-squeezed');
};

var listeners = function() {
	var applyActive = false;
	$('#applyButton').click(function(event) {
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
			hideSignupForm();
		}
	});
	$('#loginMeow').click(function(event) {
		if (applyActive) {
			hideSignupForm();
		}
		showLoginForm();
	});
	$('#loginForm button').click(function(event) {
		if (applyActive) {
			applyActive = false;
			hideLoginForm();
		}
	});
};

$('.orange-juice').ready(function() {
	listeners();
});