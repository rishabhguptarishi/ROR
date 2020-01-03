class AddLastActivityAtToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.column :last_activity_at, :datetime
    end
  end
end
