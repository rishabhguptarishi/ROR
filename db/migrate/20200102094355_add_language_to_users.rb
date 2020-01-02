class AddLanguageToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.column :language, :string, default: 'English', null: false
    end
  end
end
