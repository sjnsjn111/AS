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

  delegate :id, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :subject, prefix: true, allow_nil: true

  class << self
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

    def import file
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          result = find_by_id(row["id"]) || new
          result.attributes = row.to_hash.slice(*row.to_hash.keys)
          result.save!
      end
    end

    def open_spreadsheet file
      case File.extname(file.original_filename)
          when ".csv" then Roo::CSV.new(file.path)
          when ".xls" then Roo::Excel.new(file.path)
          when ".xlsx" then Roo::Excelx.new(file.path)
          else raise "Unknown file type: #{file.original_filename}"
      end
    end
  end
end
