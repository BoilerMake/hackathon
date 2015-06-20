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
$(document).ready(function(){
	var last = null;
	var current = null;
	var result = null;
	$(".timeline").children('.event').each(function() {
		current = $(this);
		var className = current.attr('class');
		className = className.replace('event ', '');
		current = parseInt(className);
		if (last !== null) {
			result = Math.abs(last - current);
			var margin = result * 10;
			$(this).css("margin-top", margin);
		}
		console.log(className);
		last = current;
	});
});
$(function() {
    $("div[class^=event]").hover( function () {
        $(this).children('.display_info').fadeIn();
        $(this).children('.display_info').css("display", "inline-block")
        $(this).children('.detail').hide();
    }, function () {
        $(this).children('.display_info').hide();
        $(this).children('.detail').show();
    });
});