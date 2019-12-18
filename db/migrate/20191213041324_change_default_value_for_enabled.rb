class ChangeDefaultValueForEnabled < ActiveRecord::Migration[6.0]
  def up
    change_column_default :products, :enabled, false
  end

  def down
    change_column_default :products, :enabled, nil
  end
end
