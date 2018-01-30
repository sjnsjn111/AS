class CreateRemarkings < ActiveRecord::Migration[5.1]
  def change
    create_table :remarkings do |t|
      t.references :result
      t.references :school
      t.integer :status, default: 0
      t.text :content
      t.date :deleted_at

      t.timestamps
    end
    add_index :remarkings, [:result_id, :status]
  end
end
