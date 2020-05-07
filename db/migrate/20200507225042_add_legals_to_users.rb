class AddLegalsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :conditions_accepted, :boolean, default: false
    add_column :users, :date_of_acceptance, :string
    add_column :users, :ip_address, :string
  end
end
