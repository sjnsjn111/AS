class Target < ApplicationRecord
  acts_as_paranoid

  belongs_to :major

  scope :newest, ->{order created_at: :desc}
  scope :get_year, ->year{where year: year}
  scope :top_mark, ->year{where(year: year).order(benchmark: :desc).limit 1}

  delegate :code, to: :major, prefix: true, allow_nil: true

  class << self
    def top_school year
      Target.find_by_sql "select * from
        (SELECT sum(benchmark)/count(benchmark) as mark,
        schools.code FROM targets
        inner join majors on majors.id = targets.major_id
        inner join schools on schools.id = majors.school_id
        where targets.year = #{year}
        group by schools.code) as Temp
        order by Temp.mark desc
        limit 1"
    end
  end
end
