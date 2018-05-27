class BaseNotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_notifications, only: :index

  protected

  def load_notifications
    @notifications = Notification.get_newest.search_can_read current_user.id
    @notifications_read = Notification.get_newest.search_readed current_user.id
    @notifications_unread = @notifications - @notifications_read
  end

  def readed_notification notification
    return unless notification && user_signed_in?
    users_read_all = notification.user_readed
    if users_read_all.blank?
      notification.update_attributes user_readed: [current_user.id]
    elsif !users_read_all.include?(current_user.id)
      users_read_all << current_user.id
      notification.update_attributes user_readed: users_read_all
    end
  end
end
