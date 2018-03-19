class CreateStyleMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :style_majors do |t|
      t.string :name

      t.timestamps
    end
  end
end
