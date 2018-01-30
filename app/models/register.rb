class Register < ApplicationRecord
  acts_as_paranoid

  belongs_to :major
  belongs_to :user
  belongs_to :department
  has_one :school, through: :major
  has_many :subject_departments, through: :department
  has_many :subjects, through: :subject_departments
  has_many :results, through: :subjects
end
