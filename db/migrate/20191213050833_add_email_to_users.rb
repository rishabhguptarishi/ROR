class AddEmailToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.column :email, :string
    end
  end
end
