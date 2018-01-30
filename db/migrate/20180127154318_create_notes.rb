class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.date :start_time
      t.date :end_time
      t.text :content
      t.date :deleted_at

      t.timestamps
    end
  end
end
