class Notification < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :event, polymorphic: true

  serialize :user_read, Array
  serialize :user_readed, Array
end
