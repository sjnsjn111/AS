class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user
      t.belongs_to :event, polymorphic: true, index: true
      t.text :content
      t.text :user_read
      t.text :user_readed
      t.date :deleted_at

      t.timestamps
    end
  end
end
