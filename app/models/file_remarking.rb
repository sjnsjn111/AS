class FileRemarking < ApplicationRecord
  attr_accessor :remarkings_ids, :results_ids, :marks

  belongs_to :user
  belongs_to :school
  has_many :remarkings, dependent: :destroy
  has_many :results, through: :remarkings

  validates :reason_reject, presence: true, if: :is_rejected?

  accepts_nested_attributes_for :remarkings, allow_destroy: true

  after_create :save_remarking
  after_update :update_result, :destroy_remarking, if: :is_processed?

  enum status: %i(pending rejected approved processed)

  delegate :name, :id, :identification_number, :nationality, :birthday,
    to: :user, prefix: true, allow_nil: true
  delegate :name, to: :school, prefix: true, allow_nil: true

  scope :get_newest, ->{order created_at: :desc}
  scope :get_current, ->status{where is_current: status}
  scope :get_year, ->year{where "created_at LIKE ?", "%#{year}%"}
  scope :get_lastest, ->{order created_at: :asc}

  def self_attr_after_create remarkings_ids
    self.remarkings_ids = remarkings_ids
  end

  def self_attr_after_update results_ids, marks
    self.results_ids = results_ids
    self.marks = marks
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

  def is_rejected?
    self.rejected?
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

  private

  def is_processed?
    self.processed?
  end

  def update_result
    return unless self.is_changed?
    results_ids.each_with_index do |result_id, index|
      result = self.results.find_by id: result_id
      result.update_attributes mark: marks[index]
    end
  end

  def destroy_remarking
    self.remarkings.destroy_all unless self.remarkings.blank?
  end
end
