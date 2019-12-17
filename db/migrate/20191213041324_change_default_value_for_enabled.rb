class ChangeDefaultValueForEnabled < ActiveRecord::Migration[6.0]
  def up
    change_column_default :products, :enabled, false
  end

  def down
    #FIXME_AB: change back to default null
    raise ActiveRecord::IrreversibleMigration
  end
end
