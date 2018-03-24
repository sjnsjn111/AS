class MajorDepartment < ApplicationRecord
  acts_as_paranoid

  belongs_to :major
  belongs_to :department
  has_one :school, through: :major
  has_many :subject_departments, through: :department
  has_many :subjects, through: :subject_departments
  has_many :targets, through: :major

  scope :get_by_depart, ->ids{where department_id: ids}
  scope :get_by_major, ->id{where major_id: id}
end
