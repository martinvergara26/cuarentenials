class GivenGift < ApplicationRecord
  belongs_to :user
  belongs_to :gift
  belongs_to :birth
end
