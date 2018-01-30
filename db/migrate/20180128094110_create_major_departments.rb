class CreateMajorDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :major_departments do |t|
      t.references :major
      t.references :department
      t.date :deleted_at

      t.timestamps
    end
    add_index :major_departments, [:major_id, :department_id]
  end
end
