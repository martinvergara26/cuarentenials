class Birth < ApplicationRecord
    validates :name, presence: true
    validates :estimated_date, presence: true

    belongs_to :phase
end
