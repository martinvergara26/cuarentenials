class Gift < ApplicationRecord
    belongs_to :phase

    has_many :given_gifts
    has_many :births, through: :given_gifts
end
