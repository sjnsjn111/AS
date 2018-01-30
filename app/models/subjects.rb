class Subjects < ApplicationRecord
  acts_as_paranoid

  has_many :subject_departments, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :departments, through: :subject_departments
  has_many :users, through: :results
  has_many :major_departments, through: :departments
  has_many :majors, through: :major_departments
  has_many :schools, through: :majors
end
