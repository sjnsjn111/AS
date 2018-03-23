$(document).ready(function(){
  $(document).on('click', '#js-save-style-major', function(e){
    e.preventDefault();
    var data = {
      name: $('#name_style_major').val(),
      id: $(this).attr('data-style')
    }
    $.ajax({
      url: '/admins/style_majors/' + data.id,
      type: 'patch',
      data: {style_major: data}
    });
  });
});
