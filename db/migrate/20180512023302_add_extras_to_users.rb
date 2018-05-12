class AddExtrasToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthdate, :date
    add_column :users, :dni, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :gender, :string
  end
end
