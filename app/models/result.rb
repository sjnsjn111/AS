class Result < ApplicationRecord
  acts_as_paranoid

  belongs_to :subject
  belongs_to :user
  has_many :remarkings, dependent: :destroy
  has_many :subject_departments, through: :subject
  has_many :department, through: :subject_departments
  has_many :registers, through: :user
  has_many :majors, through: :registers
  has_many :schools, through: :majors

  scope :get_year, ->year{where "created_at LIKE ?", "%#{year}%"}
  scope :get_newest, ->{order created_at: :desc}
  scope :order_by_subject, ->{order subject_id: :asc}

  delegate :id, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :subject, prefix: true, allow_nil: true

  class << self
    def import_file file
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      results = []
      (1..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        user = User.find_by(identification_number: row["identification_number"])
        subject = Subject.find_by(code: row["code"])
        mark = row["mark"]
        if user && subject && mark &&
          result = Result.where(user_id: user.id, subject_id: subject.id)
          if result.blank?
            result = Result.new user_id: user.id, subject_id: subject.id, mark: mark
            results << result
          end
        end
      end
      Result.import results
    end

    # def average_results_by_departments
    #   hashes = {}
    #   depart_results = Department.all.includes(:results).group_by &:result_ids
    #   depart_results.each do |department|
    #   average = 0
    #     department.first.each do |result_id|
    #       result = Result.find_by id: result_id
    #       average += result.mark
    #     end
    #     hashes[department.second.first.name] = average / department.first.size
    #   end
    #   @average_results = hashes
    # end
    def rank user_id
      Result.find_by_sql "SELECT Test1.n as rank
        from(SELECT @n := @n + 1 n, Test.user_id,Test.total from
        (SELECT user_id, sum(results.mark) as total
        FROM results
        GROUP BY results.user_id
        ) as Test, (SELECT @n := 0) m
        ORDER BY Test.total desc) as Test1
        WHERE Test1.user_id = #{user_id}"
    end

    def average_mark_department
      Result.find_by_sql "SELECT subjects.name, ROUND(SUM(results.mark)/count(results.subject_id),1) AS average_mark
        FROM results
        inner join subjects on subjects.id = results.subject_id
        group by results.subject_id"
    end

    def open_spreadsheet file
      case File.extname(file.original_filename)
          when ".csv" then Roo::CSV.new(file.path)
          when ".xls" then Roo::Excel.new(file.path)
          when ".xlsx" then Roo::Excelx.new(file.path)
          else raise "Unknown file type: #{file.original_filename}"
      end
    end

    def mark_department_best department_ids, user_id
      Result.find_by_sql "SELECT sum(results.mark) as sum_mark, subject_departments.department_id
        FROM results
        join subject_departments on subject_departments.subject_id = results.subject_id
        where user_id = #{user_id} and department_id IN #{department_ids}
        group by subject_departments.department_id
        order by sum_mark desc limit 1"
    end
  end
end
