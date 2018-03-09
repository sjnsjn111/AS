$(document).ready(function(){
  $(document).on('click', '#btn-remarking', function(){
    var id = $(this).attr('data-id');
    if (CKEDITOR.instances[`content-${id}`].getData().length < 20 ) {
      alertify.error("content minimum 20 character.")
    } else {
      $('#no-remarking').remove();
      var content = $('#name-result-' + id).text();
      var html_tag = `<span class="tag" id="tag-${id}"><span>${content}&nbsp;&nbsp;
        </span><a href="#" title="Removing tag" data-id="${id}"
        class="close-tag">x</a></span>`;
      $('#text-remaring-' + id).text(I18n.t('selected_remarking'));
      $('#icon-' + id).show();
      $('.tagsinput').append(html_tag);
      $('#remarking-' + id).modal('hide');
    }
  });
  $(document).on('click', '.close-tag', function(){
    $(this).parent().remove();
    var id = $(this).attr('data-id');
    $('#text-remaring-' + id).text(I18n.t('click_to_remarking'));
    CKEDITOR.instances[`content-${id}`].setData("");
    $(`#icon-${id}`).hide();
  });
  $(document).on('click', '#btn-del-remarking', function(){
    var id = $(this).attr('data-id');
    $('#text-remaring-' + id).text(I18n.t('click_to_remarking'));
    CKEDITOR.instances[`content-${id}`].setData("");
    $(`#icon-${id}`).hide();
    $('#remarking-' + id).modal('hide');
    $('#tag-' + id).remove();
  });
});
