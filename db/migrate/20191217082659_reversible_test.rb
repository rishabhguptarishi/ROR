class ReversibleTest < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          Alter Table Users Add test_reversible varchar(255)
        SQL
      end
      dir.down do
        execute <<-SQL
          Alter Table Users Drop Column test_reversible
        SQL
      end
    end
  end
end
