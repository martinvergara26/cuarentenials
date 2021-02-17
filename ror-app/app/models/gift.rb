class Gift < ApplicationRecord
    belongs_to :phase, optional: true

    # :user is the creator of the gift (pmc or requests vds)
    belongs_to :user, optional: true

    has_many :given_gifts
    has_many :births, through: :given_gifts
end
