class Address < ApplicationRecord
  belongs_to :user
  validates :state, :country, :city, :pincode, presence: true
end
