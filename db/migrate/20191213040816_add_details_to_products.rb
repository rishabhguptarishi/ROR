class AddDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    change_table :products, bulk: true do |t|
      t.column :enabled, :boolean
      t.column :discount_price, :decimal, precision: 8, scale: 2
      t.column :permalink, :string
    end
  end
end
