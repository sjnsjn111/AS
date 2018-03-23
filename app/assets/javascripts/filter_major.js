$(document).ready(function() {
  $(document).on('change', 'select[name="q[style_major_id_eq]"]', function() {
    $('button#filter-style').click();
  });
});
