/*global $:false */

var showForm = function(id) {
  $(id).fadeIn(250);
};
var hideForm = function(id) {
  $('.full-form').fadeOut(250);
};

$(document).ready(function(){
  var origTop = null;
  $(window).on("scroll", function(e) {
  	var scrollTop, navTop, isFixed;
  	var nav = $('.navigation');
  	scrollTop = $(window).scrollTop();
  	navTop = nav.offset().top;
  	isFixed = nav.hasClass('fix-div');
  	if (origTop === null) {
  		origTop = navTop;
  	}
  	if (isFixed && scrollTop <= origTop) {
  		nav.removeClass('fix-div');
  		$('.replace-div').css("display", "none");
  	} else if (scrollTop >= navTop && !isFixed) {
  		console.log("HEREEREJREIOJREOI");
  		nav.addClass('fix-div');
  		$('.replace-div').css("display", "block");
  	}
  });
});
$('#scrollBtn').on('click', function(event){     
    console.log("clicked");
});
