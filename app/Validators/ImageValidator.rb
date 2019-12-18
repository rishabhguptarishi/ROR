class ImageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\.(gif|jpg|png)\Z/i
      record.errors[attribute] << (options[:message] || "must be a GIF, JPG or PNG Image")
    end
  end
end
