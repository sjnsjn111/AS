class Register < ApplicationRecord
  acts_as_paranoid

  belongs_to :major
  belongs_to :user
  belongs_to :department
  has_one :school, through: :major
  has_many :subject_departments, through: :department
  has_many :subjects, through: :subject_departments
  has_many :targets, through: :major

  enum aspiration: %i(aspiration_1 aspiration_2 aspiration_3)

  before_create :set_year

  delegate :name, :id, to: :major, prefix: true, allow_nil: true
  delegate :name, :id, to: :department, prefix: true, allow_nil: true
  delegate :name, :people_id, :identification_number, to: :user, prefix: true, allow_nil: true

  scope :get_year, ->year{where year: year}
  scope :get_by_major, ->ids{where major_id: ids}
  scope :get_by_user, ->ids{where user_id: ids}
  scope :get_by_id, ->ids{where id: ids}
  scope :get_average_majors, ->(major_ids, year = nil) do
    year = year ? year : Time.now.year
    hashes = {}
    get_by_major(major_ids).get_year(year).includes(:major).group_by(&:major).each do |x|
      hashes[x.first.name] = (x.second.sum{|result| result.mark} / x.second.size).round 1
    end
    hashes
  end
  scope :get_register_success, ->(target_amount, major_id, aspiration, year = nil) do
    year = year ? year : Time.now.year
    get_year(year).where(major_id: major_id, aspiration: aspiration).order(mark: :desc)
      .limit(target_amount)
  end
  scope :get_register_fail, ->(bench_mark, major_id, aspiration, year = nil) do
    year = year ? year : Time.now.year
    get_year(year).where "major_id = ? AND aspiration = ? AND mark < ?", major_id, aspiration, bench_mark
  end
  scope :get_limit_by_user_id, -> major_id, user_ids, year = nil do
    year = year ? year : Time.now.year
    get_year(year).where(user_id: user_ids, major_id: major_id).order(mark: :desc).last
  end
  scope :get_register_success_by_mark, ->(bench_mark, major_id, aspiration, year = nil) do
    year = year ? year : Time.now.year
    get_year(year).where "major_id = ? AND aspiration = ? AND mark >= ?", major_id, aspiration, bench_mark
  end
  scope :get_success_no_major, -> target_amount do
    order(mark: :desc).limit target_amount
  end
  scope :aspiration_increase, ->{order aspiration: :asc}

  def set_year
    self.year = year ? year : Time.now.year
  end

  class << self
    def hot_school year
      Register.find_by_sql "select * from
        (SELECT count(*) as num, schools.code FROM registers
        inner join majors on majors.id = registers.major_id
        inner join schools on schools.id = majors.school_id
        where registers.year = #{year}
        group by schools.code) as Temp
        order by num desc limit 1"
    end

    def open_spreadsheet file
      case File.extname(file.original_filename)
          when ".csv" then Roo::CSV.new(file.path)
          when ".xls" then Roo::Excel.new(file.path)
          when ".xlsx" then Roo::Excelx.new(file.path)
          else raise "Unknown file type: #{file.original_filename}"
      end
    end

    def import_file file
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      registers = []
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        user = User.find_by identification_number: row["ma thi sinh"]
        major = Major.find_by code: row["ma nganh"]
        aspiration = row["NV"] - 1
        get_department = RegistersService.new user, major.id
        department_id = get_department.get_best_depart
        mark = get_department.get_mark_from_depart
        if user && major && department_id && mark && aspiration
          register = Register.where user_id: user.id, aspiration: aspiration
          if register.blank?
            register = user.registers.build major_id: major.id, department_id: department_id,
              mark: mark, aspiration: aspiration, year: Time.now.year
            registers << register
          end
        end
      end
      raise ActiveRecord::RecordInvalid if registers.blank?
      Register.import registers
    end
    # def hot_major
    #   Register.find_by_sql "SELECT count(major_id) as num, major_id
    #     FROM registers
    #     group by registers.major_id
    #     order by num desc
    #     limit 1"
    # end
    # def get_average_majors major_ids, year
    #   get_by_major(major_ids).get_year(year).includes(:major).group_by(&:major).

    # end

  end
end
