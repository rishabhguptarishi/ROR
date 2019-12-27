class SingleNestingValidator < ActiveModel::Validator
  def validate(record)
    unless record.root?
      unless record.parent.root?
        record.errors[:discount_price] << 'Sub categories cannot have more sub-categories'
      end
    end
  end
end
