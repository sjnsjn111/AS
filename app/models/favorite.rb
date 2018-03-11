class Favorite < ApplicationRecord
  belongs_to :major
  belongs_to :user
end
