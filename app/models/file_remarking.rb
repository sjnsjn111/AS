class FileRemarking < ApplicationRecord
  attr_accessor :remarkings_ids

  belongs_to :user
  belongs_to :school
  has_many :remarkings, dependent: :destroy

  accepts_nested_attributes_for :remarkings, allow_destroy: true

  after_create :save_remarking

  enum status: %i(pending reject approve processed)

  delegate :name, :id, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :school, prefix: true, allow_nil: true

  scope :get_newest, ->{order created_at: :desc}
  scope :get_current, ->status{where is_current: status}

  def self_attr_after_create remarkings_ids
    self.remarkings_ids = remarkings_ids
  end

  def save_remarking
    remarkings = []
    remarkings_ids.each do |key, value|
      next if value.blank?
      remarkings << self.remarkings.build(result_id: key, content: value)
    end
    Remarking.transaction do
      Remarking.import! remarkings
    end
  end
end
