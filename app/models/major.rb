class Major < ApplicationRecord
  acts_as_paranoid

  belongs_to :school
  belongs_to :style_major
  has_many :major_departments, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :registers, dependent: :destroy
  has_many :users, through: :registers
  has_many :departments, through: :major_departments
  has_many :subjects_departmants, through: :departments
  has_many :subjects, through: :subjects_departmants
  has_many :favorites, dependent: :destroy

  validates :name, presence: true,
    length: {minimum: Settings.min_name}
  validates :code, presence: true, uniqueness: true,
    length: {minimum: Settings.min_code}
  validate :name_unique_in_school

  delegate :name, :id, to: :school, prefix: true, allow_nil: true

  scope :get_by, ->ids {where id: ids}
  scope :newest, ->{order created_at: :desc}
  scope :get_by_department, ->(department_ids) do
    joins(:major_departments).where "major_departments.department_id IN (?)", department_ids
  end
  scope :get_by_school, ->school_id{where school_id: school_id}

  mount_uploader :picture, PictureMajorUploader

  validate :picture_size

  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, I18n.t("less_than_5")
    end
  end

  def name_unique_in_school
    if self.school.majors.pluck(:name).include? self.name
      major = Major.find_by name: self.name
      return if major.id == self.id
      errors.add :name, I18n.t("name_unique_in_school")
    end
  end

  class << self
    def hot_major year
      Major.find_by_sql "SELECT count(registers.major_id) as num,
        majors.code FROM majors
        inner join registers on registers.major_id = majors.id
        where registers.year = #{year}
        group by majors.code
        order by num desc
        limit 1"
    end
  end
end
