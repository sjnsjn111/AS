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

  scope :get_by, ->(ids){where id: ids}
  scope :newest, ->{order created_at: :desc}

  class << self
    def average_results_by_departments departments
      hashes = {}
      departments.all.each do |department|
        average = Settings.default_value
        department_users = department.results.includes(:user).group_by &:user_id
        count = Settings.default_value
        department_users.each do |department_user|
          if department_user.second.size == Settings.num_standard
            count += 1
            average += department_user.second.pluck(:mark).inject(0){|sum,x| sum + x}
          end
        end
        hashes[department.name] = average / (count*Settings.num_standard) unless count == Settings.default_value
      end
      hashes
    end
  end
end
