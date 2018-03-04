$('#body-table-result td').keypress(function(e) {
  if (e.which == 13){
    e.preventDefault();
    user_id = $(this).attr('data');
    role = $(this).attr('role');
    subject_id = $(this).attr('data-subject');
    mark = parseFloat($(this).html());
    page = $('#page').attr('data');
    if (mark >= 0 && mark <= 10) {
      $.ajax({
        url: 'results/' + user_id,
        type: 'PATCH',
        data: {mark: mark, role: role, subject_id: subject_id, page: page}
      });
    }
    else
    {
      $(this).html("");
    }
  }
});
