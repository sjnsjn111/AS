class Remarking < ApplicationRecord
  acts_as_paranoid

  belongs_to :result
  belongs_to :school
  has_one :user, through: :result
  has_one :subject, through: :result

  validates :content, presence: true,
    length: {minimum: Settings.min_content}

  enum status: %i(pending reject approve processed)

  delegate :name, to: :subject, prefix: true, allow_nil: true
  delegate :name, :id, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :school, prefix: true, allow_nil: true

  scope :get_newest, ->{order created_at: :desc}
end
