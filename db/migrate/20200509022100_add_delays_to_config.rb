class AddDelaysToConfig < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :time_between_slides, :integer
    add_column :configs, :time_delay_with_header, :integer
  end
end
