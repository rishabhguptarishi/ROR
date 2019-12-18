require 'URI'
class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.match(URI.regexp)
      record.errors[attribute] << (options[:message] || "must be a proper URL")
    end
  end
end
