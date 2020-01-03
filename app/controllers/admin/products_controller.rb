module Admin
  class ProductsController < AdminBaseController
    def index
      category = Category.find(params[:category_id])
      if category
        @products = category.all_products
      else
        redirect_to admin_categories_path, notice: "Selected Category doesnt exist"
      end
    end
  end
end
