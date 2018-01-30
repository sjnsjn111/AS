class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.text :school_id
      t.date :deleted_at

      t.timestamps
    end
    add_index :departments, :name
  end
end
