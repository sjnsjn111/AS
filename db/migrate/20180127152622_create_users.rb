class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.date :birthday
      t.string :email
      t.string :phone
      t.text :address
      t.integer :sex
      t.string :people_id
      t.integer :role, default: 0
      t.string :nation
      t.string :nationality
      t.text :avatar
      t.integer :year
      t.date :deleted_at

      t.timestamps
    end
    add_index :users, [:name, :role]
  end
end
