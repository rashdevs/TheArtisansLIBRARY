class AddBorrowingFieldsToBooks < ActiveRecord::Migration[7.0]
  def change
    # Only add columns that don't already exist
    add_column :books, :borrowed_on, :date unless column_exists?(:books, :borrowed_on)
    add_column :books, :returned_on, :date unless column_exists?(:books, :returned_on)
    # Add other fields here if necessary
  end
end

