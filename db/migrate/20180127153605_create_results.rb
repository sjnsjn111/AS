class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.references :user
      t.references :subject
      t.float :mark
      t.date :deleted_at

      t.timestamps
    end
  end
end
