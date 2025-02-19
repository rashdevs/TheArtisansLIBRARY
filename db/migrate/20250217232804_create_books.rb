class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :genre
      t.date :published_date
      t.string :status
      t.string :borrower_name
      t.date :borrowed_on
      t.date :returned_on

      t.timestamps
    end
  end
end
