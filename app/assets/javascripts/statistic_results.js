$(document).ready(function() {
  $(document).on('change', 'select[name="department"]', function() {
    $.ajax('/statistic_result', {
      type: 'GET',
      data: {id: $(this).val()}
    });
  });
});
