class Note < ApplicationRecord
  acts_as_paranoid

  enum style: %i(remarking aspiration)

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_time_cannot_be_past_of_end_time, if: :start_time? && :end_time?

  scope :notes_lastest, ->{order created_at: :asc}
  scope :get_year, ->year{where "created_at LIKE ?","%#{year}%"}

  def start_time_cannot_be_past_of_end_time
    if end_time < start_time
      errors.add :end_time, I18n.t("start_time_cannot_be_past_of_end_time")
      errors.add :start_time, I18n.t("start_time_cannot_be_past_of_end_time")
    end
  end
end
