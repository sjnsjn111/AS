class Review < ApplicationRecord
  acts_as_paranoid

  belongs_to :major
end
