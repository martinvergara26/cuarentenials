class Timeslot < ApplicationRecord

  belongs_to :birth
  belongs_to :interaction, optional: true

end
