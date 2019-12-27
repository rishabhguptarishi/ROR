class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :state
      t.string :city
      t.string :country
      t.string :pincode
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
