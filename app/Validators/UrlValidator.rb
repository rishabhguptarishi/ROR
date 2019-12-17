class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\.(gif|jpg|png)\Z/i
      record.errors[attribute] << (options[:message] || "Please supply a GIF, JPG or PNG Image URL")
    end
  end
end
