class SubjectDepartment < ApplicationRecord
  acts_as_paranoid

  belongs_to :subjects, dependent: :destroy
  belongs_to :department, dependent: :destroy
  has_many :results, through: :subjects
  has_many :major_department, through: :department
end
