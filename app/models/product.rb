class Product < ActiveRecord::Base
  has_many :line_items, dependent: :restrict_with_exception
  has_many :orders, :through => :line_items
  has_many :carts, :through => :line_items
#  before_destroy :ensure_not_referenced_by_any_line_item
  before_validation :ensure_title_exists
  before_validation :ensure_discount_price_exists
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: -> {price.present?}
  validates :title, uniqueness: { case_sensitive: false }
  validates :permalink, uniqueness: { case_sensitive: false }, format: {with: /\A([[:alnum:]]+\-){2,}[[:alnum:]]+\Z/i}
  validates_length_of :description_length, minimum: 5, maximum: 5, too_short: "is too short must be atleast %{count} words", too_long: "must have at most %{count} words"
  validates :image_url, presence: true, url: true, image: true
  validates_with DiscountPriceValidator
  # validates :discount_price, numericality: { less_than: :price }, if: -> {price.present?}

#  private def ensure_not_referenced_by_any_line_item
#    unless line_items.empty?
#      errors.add(:base, 'Line Items Present')
#      throw :abort
#    end
#  end

  private def description_length
    description.strip.split(%r{\s})
  end

  private def ensure_title_exists
    if title.blank?
      self.title = 'abc'
    end
  end

  private def ensure_discount_price_exists
    if price.present? && discount_price.blank?
      self.discount_price = price
    end
  end
end
