class Birth < ApplicationRecord
    validates :name, presence: true
    validates :estimated_date, presence: true

    has_many :given_gifts
    has_many :gifts, through: :given_gifts
    has_many :timeslots

    belongs_to :phase
    belongs_to :user
end
