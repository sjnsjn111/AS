class Major < ApplicationRecord::Base
  acts_as_paranoid

  belongs_to :school
  has_many :major_departments, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :registers, dependent: :destroy
  has_many :users, through: :registers
  has_many :departments. through: :major_departments
  has_many :subjects_departmants, through: :departments
  has_many :subjects, through: :subjects_departmants
end
