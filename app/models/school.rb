class School < ApplicationRecord
  acts_as_paranoid

  has_many :majors, dependent: :destroy
  has_many :remarkings, dependent: :destroy
  has_many :teacher, dependent: :destroy
  has_many :registers, through: :majors
  has_many :reviews, through: :majors
  has_many :users, through: :registers
  has_many :major_departments, through: :majors
  has_many :departments, through: :major_departments
  has_many :subject_departments, through: :departments
  has_many :subjects, through: :subject_departments
end
