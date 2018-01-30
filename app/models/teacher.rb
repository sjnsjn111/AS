class Teacher < ApplicationRecord
  acts_as_paranoid

  belongs_to :school
end
