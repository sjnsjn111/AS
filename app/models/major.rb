class Major < ApplicationRecord
  acts_as_paranoid

  belongs_to :school
  has_many :major_departments, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :registers, dependent: :destroy
  has_many :users, through: :registers
  has_many :departments, through: :major_departments
  has_many :subjects_departmants, through: :departments
  has_many :subjects, through: :subjects_departmants

  validates :name, presence: true,
    length: {minimum: Settings.min_name}
  validates :code, presence: true, uniqueness: true,
    length: {minimum: Settings.min_code}
  validate :name_unique_in_school

  delegate :name, to: :school, prefix: true, allow_nil: true

  scope :get_by, ->ids {where id: ids}
  scope :newest, ->{order created_at: :desc}

  mount_uploader :picture, PictureMajorUploader

  validate :picture_size

  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, t("less_than_5")
    end
  end

  class << self
    def hot_major year
      Major.find_by_sql "SELECT count(registers.major_id) as num,
        majors.code FROM majors
        inner join registers on registers.major_id = majors.id
        where registers.created_at like '%#{year}%'
        group by major_id
        order by num desc
        limit 1"
    end
  end
end
