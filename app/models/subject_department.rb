class SubjectDepartment < ApplicationRecord
  acts_as_paranoid

  belongs_to :subject, dependent: :destroy
  belongs_to :department, dependent: :destroy
  has_many :results, through: :subject
  has_many :users, through: :results
  has_many :major_departments, through: :department
  has_many :majors, through: :major_departments

  scope :newest, ->{order created_at: :desc}
end
