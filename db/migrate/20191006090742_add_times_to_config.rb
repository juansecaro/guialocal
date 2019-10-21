class AddTimesToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :number_of_points, :integer
    add_column :configs, :number_of_promos, :integer
    add_column :configs, :number_of_events, :integer
  end
end
