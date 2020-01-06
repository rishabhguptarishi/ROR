class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product
  scope :user_rating, -> (user_id) { where(user_id: user_id) }
end
