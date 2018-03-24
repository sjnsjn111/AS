/* Set the width of the side navigation to 250px and the left margin of the page content to 250px */
function openNav() {
  document.getElementById("sidebar-scroll").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
  $('.avatar').height('185');
  $('.avatar').width('135');
  $('.btn-avatar').css('position','relative');
  $('.btn-avatar').css('right','20px');
  $('#user-search').css('width','1000px');
  $('#user-search').css('margin-left','100px');
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0 */
function closeNav() {
  document.getElementById("sidebar-scroll").style.width = "0";
  document.getElementById("main").style.marginLeft = "0";
  $('#user-search').css('width','1200px');
  $('#user-search').css('margin-left','0');
}

$(document).ready(function() {
  $(document).on('click', 'nav.navbar-user li', function() {
    $(this).addClass('active');
  });
});
