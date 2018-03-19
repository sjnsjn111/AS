$(document).ready(function() {
  $(document).on('change', '.select-school', function() {
    var register_id = $(this).attr('data-id');
    var school_id = $(this).val();
    $('#select-major-' + register_id).val('');
    if (school_id !== '') {
      $('#select-major-' + register_id).children().not('option.option-major-' + register_id + '-' + school_id).hide();
      $('.option-major-' + register_id + '-' + school_id).show();
      $('.no-change-major').show();
    } else {
      $('#select-major-' + register_id).children().show();
    }
  });

  $(document).on('click', '#btn-change-aspiration', function(event){
    event.preventDefault();
    var dataForm = {
      aspiration_1: getDataForm('form-register-0'),
      aspiration_2: getDataForm('form-register-1'),
      aspiration_3: getDataForm('form-register-2')
    };
    var registed_ids = $('input[name=major_registed_ids]').val();
    if (registed_ids !== '') {
      var ids = $('input[name=major_registed_ids]').val().split(' ');
      debugger
      if (checkArray(dataForm.aspiration_1.major_id,  ids) || checkArray(dataForm.aspiration_2.major_id,  ids) || checkArray(dataForm.aspiration_3.major_id,  ids) || checkNullRepeat(dataForm.aspiration_1.major_id, dataForm.aspiration_2.major_id, dataForm.aspiration_3.major_id)) {
        swal('Information invalid!', 'Please check again information', 'error');
      } else {
        swal({
          title: I18n.t('sure'),
          text: I18n.t('confirm_suggestions'),
          icon: 'info',
          buttons: true,
          primaryMode: true,
        })
        .then(function(isConfirm){
          if (isConfirm) {
            $.ajax({
              url: '/suggestion_register',
              type: 'GET',
              data: dataForm,
              success: function(result) {
                $('#suggestions').html(result);
                $('#change-aspiration').css('opacity','0.5');
                $('select').prop('disabled', true)
                $('#btn-change-aspiration').hide(700);
                $('#suggestions').show(700);
              },
              error: function (result) {
                alertify.error('Error tranmission.');
              }
            });
          }
        });
      }
    }
  });

  $(document).on('click', '#btn-back', function() {
    $('#change-aspiration').css('opacity','1');
    $('select').prop('disabled', false)
    $('#btn-change-aspiration').show(700);
    $('#suggestions').hide(700);
  });

  $(document).on('click', '#btn-confirm', function() {
    $('select').prop('disabled', false);
    var dataForm = {
      aspiration_1: getDataForm('form-register-0'),
      aspiration_2: getDataForm('form-register-1'),
      aspiration_3: getDataForm('form-register-2')
    };
    $('select').prop('disabled', true);
    swal({
      title: I18n.t('sure'),
      text: I18n.t('confirm_change_aspiration'),
      icon: 'warning',
      buttons: true,
      primaryMode: true,
    })
    .then(function(isConfirm){
      if (isConfirm) {
        $.ajax({
          url: '/change_register',
          type: 'PATCH',
          data: dataForm,
          success: function(result) {
            if (result.success === false) {
              swal('Changed failure!', result.message, 'error');
            } else {
              $('#btn-change-aspiration').remove();
              $('#suggestions').remove();
              swal('Changed success!', 'You clicked the button!', 'success');
            }
          },
          error: function (result) {
            alertify.error('Error tranmission.');
          }
        });
      };
    });
  });

  function getDataForm (element) {
    var getElement = document.getElementsByClassName(element);
    var getData = new FormData(getElement[0]);
    var data = {
      major_id: getData.get('register[major_id]'),
      aspiration: getData.get('register[aspiration]')
    }
    return data;
  };

  function checkArray(id, ids) {
    if ($.inArray(id, ids) === -1) {
      return false;
    } else {
      if ($('.select-aspiration-' + $.inArray(id, ids)).val() != $('.select-aspiration-' + $.inArray(id, ids)).attr('data-id') && $('.select-aspiration-' + $.inArray(id, ids)).val() !== '') {
        return false;
      } else {
        return true;
      }
    }
  };

  function checkNullRepeat(id1, id2, id3) {
    if (id1 === '' && id2 === '' && id3 === '' || ((id1 === id2 && id1 !== '' )|| (id1 === id3 && id1!== '') || (id2 === id3 && id2 !== ''))) {
      return true
    } else {
      return false
    }
  };
});
