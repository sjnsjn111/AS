class AddColumnsToTargets < ActiveRecord::Migration[5.1]
  def up
    add_column :targets, :job, :float
    drop_table :reviews
  end
end
