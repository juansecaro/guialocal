class ChangeCreditosToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :creditos, :float
  end
end
