$(document).ready(function () {
  $('.btn-login-user').click(function () {
    $('#modal-login').modal('show');
  });

  $(document).on('submit', '#form-login', function (e) {
    e.preventDefault();
    var url = $(this).attr('action');
    $.ajax({
      type: 'POST',
      url: url,
      data: $(this).serialize(),
      dataType: 'json',
      success: function (response) {
        if (response.success) {
          window.location.href = response.link_redirect;
          alertify.success(response.message);
        } else {
          alertify.error(response.message);
        }
      }
    });
  });

  $(document).on('submit', '#form-forgot-password', function (e) {
    e.preventDefault();
    $('.loading-ajax').fadeIn();
    var url = $(this).attr('action');
    $.ajax({
      type: 'POST',
      url: url,
      data: $(this).serialize(),
      dataType: 'json',
      success: function (response) {
        if (response.success) {
          alertify.success(response.message);
          $('#modal-login').modal('hide');
        } else {
          alertify.error(response.message);
        }
      }
    });
  });

  $('.link-forgot-password').click(function () {
    $('.form-fogot').show(700);
    $('.form-login').hide(700);
  });

  $('.link-forgot-login').click(function () {
    $('.form-login').show(700);
    $('.form-fogot').hide(700);
  });
});