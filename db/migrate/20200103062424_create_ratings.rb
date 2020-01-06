class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.decimal :rating, precision: 3, scale: 2
      t.references :user
      t.references :product

      t.timestamps
    end
  end
end
