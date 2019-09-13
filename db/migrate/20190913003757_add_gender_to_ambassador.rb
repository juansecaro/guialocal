class AddGenderToAmbassador < ActiveRecord::Migration[5.1]
  def change
    add_column :ambassadors, :gender, :integer
  end
end
