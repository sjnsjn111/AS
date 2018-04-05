$(document).ready( function() {
  $('#message-flash').delay(4000).fadeOut();

  if (window.location.pathname === "/") {
    $('section#home.header').css('padding-top', '0');
    $('.search-bar').css('margin-top', '20px');
  }

  $(function() {
    var header = $('.topbar-main #tilte-bar');
    $(window).scroll(function() {
      var scroll = $(window).scrollTop();

      if (scroll >= 150) {
        header.addClass('display-none');
      } else {
        header.removeClass('display-none');
      }
    });
  });
});

$(window).on('load', function () {
  if ($('a[href="' + window.location.pathname + '"]').parent().attr('class') === "has-submenu") {
    $('a[href="' + window.location.pathname + '"]').parent().addClass('active');
  } else {
    $('a[href="' + window.location.pathname + '"]').parent().parent().parent().addClass('active');
  }
});
