class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.references :major
      t.references :user

      t.timestamps
    end
  end
end
