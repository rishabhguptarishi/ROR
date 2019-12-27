class AddLineItemsCountToCarts < ActiveRecord::Migration[6.0]
  def change
    change_table :carts, bulk: true do |t|
      t.column :line_items_count, :integer, default: 0, null: false
    end
  end
end
