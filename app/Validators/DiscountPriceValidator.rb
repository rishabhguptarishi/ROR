class DiscountPriceValidator < ActiveModel::Validator
  def validate(record)
    if record.discount_price.present? && record.price.present?
      record.errors[:discount_price] << 'Discount price must be less than price' unless record.price > record.discount_price
    else
      record.errors[:discount_price] << 'Please provide prices'
    end
  end
end
