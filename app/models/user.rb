class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
  acts_as_paranoid

  has_many :results, dependent: :destroy
  has_many :registers, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :remarkings, through: :results
  has_many :majors, through: :registers
  has_many :schools, through: :majors
  has_many :subjects, through: :results
  has_many :departments, through: :results
  has_many :major_departments, through: :majors
  has_many :departments, through: :major_departments

  validates :name, presence: true
  validates :email, presence: true
  validates :people_id, presence: true
  validates :identification_number, presence: true

  enum role: %i(student teacher admin)
  enum sex: %i(unknown male female)
  enum level: %i(university college Intermediate)

  mount_uploader :avatar, PictureUploader

  def picture_size
    if avatar.size > 5.megabytes
      errors.add :avatar, t("less_than_5")
    end
  end
end
