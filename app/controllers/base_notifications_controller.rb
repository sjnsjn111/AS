class BaseNotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_notifications, only: :index

  protected

  def load_notifications
    @notifications = Notification.get_newest.search_can_read(current_user.id)
  end
end
