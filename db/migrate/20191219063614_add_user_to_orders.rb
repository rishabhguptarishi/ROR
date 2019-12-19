class AddUserToOrders < ActiveRecord::Migration[6.0]
  def change
    if column_exists? :orders, :user_id
      #remove_foreign_key :orders, :users
      remove_column :orders, :user_id
    end
    add_reference :orders, :user, null: true, foreign_key: true
  end
end
