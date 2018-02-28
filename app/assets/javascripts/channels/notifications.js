$(document).ready(function() {
  (function() {
    App.notifications = App.cable.subscriptions.create({
      channel: 'NotificationsChannel'
    },
    {
      connected: function() {
      },
      disconnected: function() {
      },
      received: function(data) {
        current_user = parseInt($('#current-user-id').val());
        if (data.list_received != null && data.list_received.includes(current_user))
        {
          $('#get-noti').prepend('' + data.notification);
          $counter = $('#noti-counter').text();
          val = parseInt($counter);
          val++;
          $('#noti-counter').text(val);
        }
      },
    });
  }).call(this);
});
