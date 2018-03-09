$(document).ready(function(){
  $('#edit_user').validate({
    errorPlacement: function (error, element) {
      error.insertAfter(element);
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
