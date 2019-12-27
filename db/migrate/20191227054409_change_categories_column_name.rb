class ChangeCategoriesColumnName < ActiveRecord::Migration[6.0]
  def change
    change_table :categories do |t|
      t.rename :parent_id, :category_id
    end
  end
end
