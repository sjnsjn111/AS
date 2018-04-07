$(document).ready(function() {
  $(document).on('change', 'select[name="department"], select[name="subjects"]', function() {
    $('#btn-seach-average').click();
  });

  $(document).on('change', 'select[name="schools"], select[name="department"] ,select[name="aspirations"]', function() {
    $('#btn-seach').click();
  });
});
