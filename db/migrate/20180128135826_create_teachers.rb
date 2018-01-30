class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.references :user
      t.references :school
      t.date :deleted_at

      t.timestamps
    end
  end
end
