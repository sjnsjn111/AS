class Register < ApplicationRecord
  acts_as_paranoid

  belongs_to :major
  belongs_to :user
  belongs_to :department
  has_one :school, through: :major
  has_many :subject_departments, through: :department
  has_many :subjects, through: :subject_departments
  has_many :results, through: :subjects

  enum aspiration: %i(aspiration_1 aspiration_2 aspiration_3)

  delegate :name, to: :major, prefix: true, allow_nil: true

  scope :get_year, ->year{where "created_at LIKE ?", "%#{year}%"}

  class << self
    def hot_school datetime
      Register.find_by_sql "select * from
        (SELECT count(*) as num, schools.code FROM registers
        inner join majors on majors.id = registers.major_id
        inner join schools on schools.id = majors.school_id
        where registers.created_at < '#{datetime}'
        group by school_id) as Temp
        order by num desc limit 1"
    end

    # def hot_major
    #   Register.find_by_sql "SELECT count(major_id) as num, major_id
    #     FROM registers
    #     group by registers.major_id
    #     order by num desc
    #     limit 1"
    # end
  end
end
