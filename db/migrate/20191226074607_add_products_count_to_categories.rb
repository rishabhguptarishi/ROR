class AddProductsCountToCategories < ActiveRecord::Migration[6.0]
  def change
    change_table :categories, bulk: true do |t|
      t.column :products_count, :integer, default: 0, null: false
    end
  end
end
