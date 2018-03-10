class CreateRemarkings < ActiveRecord::Migration[5.1]
  def change
    create_table :remarkings do |t|
      t.references :result
      t.references :file_remarking
      t.text :content
      t.text :reply
      t.date :deleted_at

      t.timestamps
    end
  end
end
