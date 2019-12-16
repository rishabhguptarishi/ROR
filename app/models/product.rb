class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  validates :price, numericality: { greater_than_or_equal_to: 0.01 } if :price.present?
  validates :title, presence: true, uniqueness: true
  validates :permalink, uniqueness: true, format: {with: /\A([[:alnum:]]+\-){2,}[[:alnum:]]+\Z/i}
  validates :description, presence: true, format: {with: /\A([[:alnum:][:punct:]]+[[:space:]]){4,9}[[:alnum:][:punct:]]+\Z/}
  validates :image_url, presence: true, url: true
#  validates :discount_price, numericality: { greater_than: :price }
  validates_with DiscountPriceValidator

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items Present')
      throw :abort
    end
  end
end

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\.(gif|jpg|png)\Z/i
      record.errors[attribute] << (options[:message] || "Please supply a GIF, JPG or PNG Image URL")
    end
  end
end

class DiscountPriceValidator < ActiveModel::Validator
  def validate(record)
    unless record.price > record.discount_price
      record.errors[:discount_price] << 'Discount price must be less than price'
    end
  end
end
