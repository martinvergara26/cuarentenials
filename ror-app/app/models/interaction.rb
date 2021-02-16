class Interaction < ApplicationRecord
  belongs_to :phase

  has_many :timeslots
end
