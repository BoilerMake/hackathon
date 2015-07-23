/*global $:false */

var showForm = function(id) {
  $(id).fadeIn(250);
};
var hideForm = function(id) {
  $('.full-form').fadeOut(250);
};

$(document).ready(function(){
  $("#new_interest_signup").on('ajax:success', function(e, data, status, xhr){
    console.log(data);
  }).on('ajax:error', function(e, data, status, error){
    console.log(error);
  });
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
  		nav.addClass('fix-div');
  		$('.replace-div').css("display", "block");
  	}
  });
  var leftHeight = $(".column-left").height();
  var calcHeight = leftHeight - $(".gallery-button").height() - 15 - 24;
  $(".video").css("height", calcHeight);
});


