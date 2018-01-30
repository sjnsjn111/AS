class MajorDepartment < ApplicationRecord::Base
  acts_as_paranoid

  belongs_to :major
  belongs_to :departments
  has_one :school, through: :major
  has_many :subject_departments. through: :departments
  has_many :subjects, through: :subject_departments
  has_many :targets, through: :major
end
