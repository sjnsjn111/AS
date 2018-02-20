class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.datetime :time
      t.text :content
      t.integer :style
      t.boolean :is_start, default: 0
      t.date :deleted_at

      t.timestamps
    end
  end
end
