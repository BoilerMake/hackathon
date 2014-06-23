$(function() {
  $('#invite-send').on('click', function() {
    $(this).parents('form:first').submit();
  })
});
