module Admin
  class ProductsController < AdminBaseController
    def index
      category = Category.find(params[:category_id])
      @products = category.products
      @products << category.sub_category_products
    end
  end
end
