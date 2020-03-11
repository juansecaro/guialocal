class AddHeaderToConfigs < ActiveRecord::Migration[5.1]
  def change
    add_column :configs, :header, :string
  end
end
