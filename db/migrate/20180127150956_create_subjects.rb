class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :code
      t.date :deleted_at

      t.timestamps
    end
    add_index :subjects, [:name, :code]
  end
end
