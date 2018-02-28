class BaseNotificationsController < ApplicationController
  before_action :authenticate_user!

  protected

  def load_notifications
    @notifications = Notification.get_newest.search_can_read(current_user.id)
  end
end
