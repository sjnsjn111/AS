class Notification < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :event, polymorphic: true, optional: true

  after_create :push_notify

  serialize :user_read, Array
  serialize :user_readed, Array

  enum style: %i(add_student delete_student add_teacher delete_teacher remarking_pending
    remarking_rejected remarking_approved remarking_processed)

  scope :get_newest, ->{order created_at: :desc}

  class << self
    def create_notification user_read, user, style
      Notification.transaction requires_new: true do
        user_id = user ? user.id : nil
        Notification.create! user_read: user_read, user_id: user_id,
          style: style
      end
    end

    def search_readed user_id
      self.select { |x| x.user_readed.include? user_id}
    end

    def search_can_read user_id
      self.select { |x| x.user_read.include? user_id}
    end
  end

  private

  def push_notify
    ActionCable.server.broadcast "notification_channel",
      notification: render_notification(self), list_received: list_received
  end

  def render_notification notification
    ApplicationController.renderer.render partial: "notifications/notification",
      locals: {notification: notification}
  end

  def list_received
    lists_received = self.user_read
    lists_received
  end
end
