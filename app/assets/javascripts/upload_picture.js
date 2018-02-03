$(document).ready(function(){
  $('#user_avatar').bind('change', function() {
    var size_in_megabytes = this.files[0].size/200/250;
    if (size_in_megabytes > 5) {
      alertify.error(I18n.t('error_upload_size'));
    }
  });
});
