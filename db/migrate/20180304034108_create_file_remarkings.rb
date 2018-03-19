class CreateFileRemarkings < ActiveRecord::Migration[5.1]
  def change
    create_table :file_remarkings do |t|
      t.references :school
      t.references :user
      t.integer :status, default: 0
      t.boolean :is_current, default: true
      t.boolean :is_changed, default: false
      t.date :deleted_at

      t.timestamps
    end
  end
end
