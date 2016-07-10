$(document).ready(function() {
  var note_html = '<div class="form-group"><textarea placeholder="Note" rows="4" name="notes[][text]" class="form-control"></textarea></div>';

  $("#addNote").click(function(e){
    e.preventDefault();
    $("fieldset").append(note_html);
  });
});
