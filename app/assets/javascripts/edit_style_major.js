$(document).ready(function(){
  $(document).on('click', '#js-save-style-major', function(e){
    e.preventDefault();
    var name = $('#name_style_major').val();
    var id = $(this).attr('data-style');
    $.ajax({
      url: '/admins/style_majors/' + id,
      type: 'patch',
      data: {name: name, id: id}
    });
  });
});
