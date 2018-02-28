class School < ApplicationRecord
  acts_as_paranoid

  has_many :majors, dependent: :destroy
  has_many :remarkings, dependent: :destroy
  has_many :registers, through: :majors
  has_many :reviews, through: :majors
  has_many :users, through: :registers
  has_many :major_departments, through: :majors
  has_many :departments, through: :major_departments
  has_many :subject_departments, through: :departments
  has_many :subjects, through: :subject_departments

  scope :get_newest, ->{order created_at: :desc}

  enum level: %i(university college intermediate)

  mount_uploader :logo, LogoSchoolUploader

  validate :picture_size
  validates :name, presence: true, uniqueness: true,
    length: {minimum: Settings.min_name}
  validates :code, presence: true, uniqueness: true,
    length: {minimum: Settings.min_code}
  validates :introducing, presence: true
  validates :level, presence: true
  validates :city, presence: true

  def picture_size
    if logo.size > 5.megabytes
      errors.add :logo, t("less_than_5")
    end
  end
end
