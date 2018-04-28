class AddYearToTables < ActiveRecord::Migration[5.1]
  def change
    add_column :notes, :year, :integer
    add_column :results, :year, :integer
    add_column :file_remarkings, :year, :integer
    add_column :registers, :year, :integer
  end
end
