class Interaction < ApplicationRecord
  belongs_to :phase, optional: true

  has_many :timeslots
end
