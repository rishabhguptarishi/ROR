class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart
  validates :product_id, uniqueness: { scope: :cart_id, message: "product can come only once in a cart"}

  def total_price
    product.price * quantity
  end
end
