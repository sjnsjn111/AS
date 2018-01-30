class Remarking < ApplicationRecord
  acts_as_paranoid

  belongs_to :result
  belongs_to :school
  has_one :user, through: :result
  has_one :subject, through: :result
end
