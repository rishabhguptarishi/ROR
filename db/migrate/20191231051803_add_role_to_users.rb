class AddRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.column :role, :string, default: 'user', null: false
    end
  end
end
