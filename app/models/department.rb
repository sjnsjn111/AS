class Department < ApplicationRecord
  acts_as_paranoid

  has_many :subject_departments, dependent: :destroy
  has_many :major_departments, dependent: :destroy
  has_many :registers, dependent: :destroy
  has_many :subjects, through: :subject_departments
  has_many :majors, through: :major_departments
  has_many :schools, through: :majors
  has_many :results, through: :subjects
  has_many :users, through: :results

  serialize :school_id, Array
end
