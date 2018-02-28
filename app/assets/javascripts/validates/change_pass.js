$(document).ready(function(){
  $('#edit_user').validate({
    errorPlacement: function (error, element) {
      // debugger;
      // $(element).children('title').remove();
      // $(element).attr('data-toggle', 'tooltip');
      // $(element).attr('data-placement', 'right');
      // $(element).attr('title', $(error).text());
      // $(element).tooltip('show');
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
