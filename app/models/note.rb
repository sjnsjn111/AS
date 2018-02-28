class Note < ApplicationRecord
  acts_as_paranoid

  enum style: %i(remarking aspiration)

  scope :notes_lastest, ->{order time: :asc}
  scope :get_year, ->year{where "created_at LIKE ?","%#{year}%"}
end
