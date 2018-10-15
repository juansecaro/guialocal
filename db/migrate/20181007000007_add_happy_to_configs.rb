class AddHappyToConfigs < ActiveRecord::Migration[5.0]
  def change
    add_column :configs, :happyhour, :boolean, default: false
  end
end
