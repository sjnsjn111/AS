class Result < ApplicationRecord
  acts_as_paranoid

  belongs_to :subject
  belongs_to :user
  has_many :remarkings, dependent: :destroy
  has_many :subject_departments, through: :subject
  has_many :department, through: :subject_departments
  has_many :registers, through: :user
  has_many :majors, through: :registers
  has_many :schools, through: :majors
end
