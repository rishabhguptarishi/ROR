class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product
  scope :user_rating, -> (user) { where(user_id: user.id) }
  after_save :update_product_average_rating
  #after_update :update_product_average_rating

  private def update_product_average_rating
    product.update_attribute(:average_rating, product.ratings.average(:rating).to_f)
  end
end
