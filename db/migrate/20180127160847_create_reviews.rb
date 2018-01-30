class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.references :major
      t.float :amount
      t.date :deleted_at

      t.timestamps
    end
    add_index :reviews, [:major_id, :created_at]
  end
end
