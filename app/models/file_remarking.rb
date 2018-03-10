class FileRemarking < ApplicationRecord
  attr_accessor :remarkings_ids

  belongs_to :user
  belongs_to :school
  has_many :remarkings, dependent: :destroy

  accepts_nested_attributes_for :remarkings, allow_destroy: true

  after_create :save_remarking

  enum status: %i(pending rejected approved processed)

  delegate :name, :id, :identification_number, :birthday, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :school, prefix: true, allow_nil: true

  scope :get_newest, ->{order created_at: :desc}
  scope :get_current, ->status{where is_current: status}
  scope :get_year, ->year{where "created_at LIKE ?", "%#{year}%"}
  scope :get_lastest, ->{order created_at: :asc}

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

  class << self
    def size_status
      total = 0
      hashes = {"pending" => 0, "rejected" => 0, "approved" => 0, "processed" => 0}
      statuses = FileRemarking.get_year(DateTime.now.year).group_by &:status
      statuses.each do |status|
        if hashes.keys.include? status[0]
          hashes[status[0]] = status[1].size
          total += status[1].size
        end
      end
      hashes["total"] = total
      hashes
    end
  end
end
