class Phase < ApplicationRecord
    has_many :births
    has_many :gifts
    has_many :interactions

    accepts_nested_attributes_for :interactions
end
