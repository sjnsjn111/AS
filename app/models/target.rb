class Target < ApplicationRecord
  acts_as_paranoid

  belongs_to :major

  scope :newest, ->{order created_at: :desc}
  scope :get_year, ->year{where year: year}
  scope :top_mark, ->year{where(year: year).order(benchmark: :desc).limit 1}
end
