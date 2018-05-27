class NotificationsController < BaseNotificationsController
  def index
    @notifications_unread.each do |notification|
      readed_notification notification
    end
  end
end
