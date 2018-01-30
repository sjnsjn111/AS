class CreateSubjectDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :subject_departments do |t|
      t.references :subject
      t.references :department
      t.date :deleted_at

      t.timestamps
    end
    add_index :subject_departments, [:subject_id, :department_id], unique: true
  end
end
