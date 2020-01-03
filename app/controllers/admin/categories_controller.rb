module Admin
  class CategoriesController < AdminBaseController
    def index
      @categories = Category.all.includes(:category)
    end
  end
end
