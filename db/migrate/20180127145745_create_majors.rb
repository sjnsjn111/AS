class CreateMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :majors do |t|
      t.references :school
      t.string :name
      t.string :code
      t.text :introducing
      t.date :deleted_at

      t.timestamps
    end
    add_index :majors, [:name, :code]
  end
end
