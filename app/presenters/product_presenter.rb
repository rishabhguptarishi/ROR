class ProductPresenter < ApplicationPresenter
  presents :product

  # Methods delegated to Presented Class Product object's product
  @delegation_methods = [:average_rating]

  delegate *@delegation_methods, to: :product

  # Start the methods
  # def full_name
  #   first_name + last_name
  # end

  def average_rating_display
    if average_rating
      "#{average_rating}/5"
    else
      'not rated'
    end
  end
end
