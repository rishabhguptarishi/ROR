class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart, counter_cache: true, optional: true
  validates :product_id, uniqueness: { scope: :cart_id, message: "product can come only once in a cart"}, if: -> {cart_id.present?}

  def total_price
    product.price * quantity
  end
end
