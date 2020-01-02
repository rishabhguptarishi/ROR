module Admin
  class CategoriesController < AdminBaseController
    def index
      @categories = Category.all
    end
  end
end
