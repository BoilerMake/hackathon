$(function() {
  $('#invite-send').on('click', function() {
    $(this).parents('form:first').submit();
  })
  $('#invitelink input').focus(function() {
    var $this = $(this);
    $this.select();

    $this.mouseup(function() {
      $this.unbind("mouseup");
      return false;
    });
  });
});
