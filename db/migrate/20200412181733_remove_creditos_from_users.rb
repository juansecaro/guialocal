class RemoveCreditosFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :creditos, :integer
  end
end
