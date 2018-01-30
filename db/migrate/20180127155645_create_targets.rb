class CreateTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :targets do |t|
      t.references :major
      t.integer :amount
      t.integer :year
      t.date :deleted_at

      t.timestamps
    end
    add_index :targets, [:major_id, :year], unique: true
  end
end
