class AddStyleMajorToMajor < ActiveRecord::Migration[5.1]
  def change
    add_reference :majors, :style_major, foreign_key: true
  end
end
