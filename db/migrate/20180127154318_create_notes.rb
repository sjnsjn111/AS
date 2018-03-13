class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :style
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
