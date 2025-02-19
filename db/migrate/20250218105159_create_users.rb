class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.integer :id_number
      t.string :name
      t.string :phone_number
      t.string :email
      t.integer :book_id
      t.string :book_name
      t.date :borrowed_on
      t.date :returned_on

      t.timestamps
    end
  end
end
