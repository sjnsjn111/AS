$(document).on('keypress', '#body-table-target td', function(e) {
  if (e.which == 13){
    e.preventDefault();
    target_id = $(this).attr('data');
    role = $(this).attr('role');
    major_id = $(this).attr('data-major');
    value = parseFloat($(this).html()) / 100;
    year = $('#year-selected').val();
    $.ajax({
      url: 'targets',
      type: 'POST',
      data: {value: value, role: role, major_id: major_id,
        target_id: target_id, year: year}
    });
  }
});

$(document).on('change', 'select#year-selected', function() {
  $('.btn-search-year').click();
});
