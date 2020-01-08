class AddAverageRatingToProducts < ActiveRecord::Migration[6.0]
  def change
    change_table :products do |t|
      t.column :average_rating, :decimal, precision: 3, scale: 2
    end
  end
end
