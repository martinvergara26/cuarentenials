class GivenGift < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :gift
  belongs_to :birth
end
