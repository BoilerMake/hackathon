var origTop = null;
$(window).scroll(function(){
	var scrollTop, navTop, isFixed;
	var nav = $('.main_nav');
	scrollTop = $(window).scrollTop();
	navTop = nav.offset().top;
	isFixed = nav.hasClass('fixed');
	if (origTop === null) {
		origTop = navTop;
	}
	if (isFixed && scrollTop <= origTop) {
		nav.removeClass('fixed');
		$('.nav_placeholder').css("display", "none");
	} else if (scrollTop >= navTop && !isFixed) {
		nav.addClass('fixed');
		$('.nav_placeholder').css("display", "block");

	}
});