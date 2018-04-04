$(document).ready(function() {
  $(document).on('change', 'select[name="department"], select[name="subjects"]', function() {
    $('#btn-seach-average').click();
    // $.ajax('/statistic_result', {
    //   type: 'GET',
    //   data: {id: $(this).val()}
    // });
  });
});
