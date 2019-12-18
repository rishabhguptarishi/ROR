class Product < ActiveRecord::Base
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  before_validation :initialize_title
  before_validation :initialize_discount_price, if: -> {price.present?}
  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, if: -> {price.present?}
  validates :title, uniqueness: { case_sensitive: false }
  validates :permalink, uniqueness: { case_sensitive: false }, format: {with: /\A([[:alnum:]]+\-){2,}[[:alnum:]]+\Z/i}
  validates_length_of :description_length, minimum: 5, maximum: 5, too_short: "is too short must be atleast %{count} words", too_long: "must have at most %{count} words"
  validates :image_url, presence: true, url: true, image: true
  validates_with DiscountPriceValidator
  # validates :discount_price, numericality: { less_than: :price }, if: -> {price.present?}

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items Present')
      throw :abort
    end
  end

  def description_length
    description.strip.split(%r{\s})
  end

  def initialize_title
    self.title = 'abc' unless title.present?
  end

  def initialize_discount_price
    self.discount_price = price unless discount_price.present?
  end
end
