class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  acts_as_paranoid

  has_many :results, dependent: :destroy
  has_many :registers, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :schools, through: :majors
  has_many :majors, through: :registers
  has_many :major_departments, through: :majors
  has_many :remarkings, through: :results
  has_many :subjects, through: :results
  has_many :subject_departmants, through: :subjects
  has_many :departments, through: :subject_departmants
  belongs_to :school, optional: true

  validates :name, presence: true
  validates :email, presence: true
  validates :people_id, presence: true
  validates :identification_number, presence: true

  enum role: %i(student teacher admin)
  enum sex: %i(unknown male female)
  enum level: %i(university college Intermediate)

  mount_uploader :avatar, PictureUploader

  scope :user_newest, ->{order created_at: :desc}

  def picture_size
    if avatar.size > 5.megabytes
      errors.add :avatar, t("less_than_5")
    end
  end

  def find_user_departments
    array = []
    subject_ids = self.subjects.pluck(:id)
    sub_departs = SubjectDepartment.all.group_by &:department_id
    sub_departs.each do |subject|
      array << subject.first if (subject.second.pluck(:subject_id) - subject_ids).blank?
    end
    array
  end

  def sum_mark
    self.results.pluck(:mark).inject(0){|sum,x| sum + x}
  end

  def is_teacher? school
    return false if self.school.id != school.id || !self.teacher?
    self.school.id == school.id
  end

  class << self
    def import file
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          user = find_by_id(row["id"]) || new
          user.attributes = row.to_hash.slice(*row.to_hash.keys)
          user.save!
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
