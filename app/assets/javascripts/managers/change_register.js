$(document).ready(function() {
  $(document).on('click', 'input[name="change_register"]', function() {
    if ($('input[name="change_register"]:checked').length > 0) {
      $('#change-result').show(700);
      $('#not-change').hide(700);
    } else {
      $('#not-change').show(700);
      $('#change-result').hide(700);
    }
  });

  $(document).on('click', '#btn-change-result', function() {
    if ($('input[name="change_register"]:checked').length > 0) {
      var marks = $('input[name=marks]').val().split(' ');
      var results_ids = $('input[name=results_ids]').val().split(' ');
      x = 0
      $.each(results_ids, function(index, result_id) {
        mark = $('input[name="file_remarking[results][' + result_id + '][mark]"]').val();
        if (parseFloat(mark) === parseFloat(marks[index])) {
          x ++;
        }
      });
      if (x === marks.length) {
        alertify.error(I18n.t('results_not_changed'));
      } else {
        $('form.edit_file_remarking').submit();
      }
    } else {
      $('form.edit_file_remarking').submit();
    }
  });
});
