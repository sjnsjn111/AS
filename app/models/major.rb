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

  delegate :name, to: :school, prefix: true, allow_nil: true

  scope :get_by, ->ids {where id: ids}
  scope :newest, ->{order created_at: :desc}

  mount_uploader :picture, PictureMajorUploader

  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, t("less_than_5")
    end
  end
end
