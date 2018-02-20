class Register < ApplicationRecord
  acts_as_paranoid

  belongs_to :major
  belongs_to :user
  belongs_to :department
  has_one :school, through: :major
  has_many :subject_departments, through: :department
  has_many :subjects, through: :subject_departments
  has_many :results, through: :subjects

  enum aspiration: %i(aspiration_1 aspiration_2 aspiration_3)

  delegate :name, to: :major, prefix: true, allow_nil: true
end
