class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :email
      t.string :code
      t.string :logo
      t.text :url_school
      t.text :introducing
      t.integer :level
      t.date :deleted_at
      t.string :city

      t.timestamps
    end
    add_index :schools, [:name, :level]
  end
end
