class CreateRegisters < ActiveRecord::Migration[5.1]
  def change
    create_table :registers do |t|
      t.references :major
      t.references :user
      t.references :department
      t.integer :aspiration
      t.boolean :status, default: 0
      t.date :deleted_at

      t.timestamps
    end
  end
end
