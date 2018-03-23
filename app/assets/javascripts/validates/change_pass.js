$(document).ready(function(){
  $('#edit_user').validate({
    errorClass: 'help-block animation-slideDown',
    errorElement: 'div',
    errorPlacement: function(error, e) {
      e.parents('.form-group').append(error);
    },
    highlight: function(e) {
      $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
      $(e).closest('.help-block').remove();
    },
    success: function(e) {
      if (e.closest('.form-group').find('.help-block').length === 2) {
        e.closest('.help-block').remove();
      } else {
        e.closest('.form-group').removeClass('has-success has-error');
        e.closest('.help-block').remove();
      }
    },
    rules: {
      "user[password]": {
        required: true,
        minlength: 6
      },
      "user[password_confirmation]": {
        required: true,
        minlength: 6
      },
      "user[current_password]": {
        required: true
      }
    },
  });
});
