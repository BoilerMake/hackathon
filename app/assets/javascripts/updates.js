$(function(){
  $("#use_short").on( 'change', function(){
    $("#short_msg").toggle();
  });
  $("#update_should_text").on('change', function(){
    $(".text-options").toggle();
  });
});
