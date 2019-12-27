class SingleNestingValidator < ActiveModel::Validator
  def validate(record)
    unless record.root?
      unless record.category.root?
        record.errors[:sub_category] << 'Sub categories cannot have more sub-categories'
      end
    end
  end
end
