class CreateConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :configs do |t|
      t.string :cities, array: true, default: []
      t.string :current_city

      t.timestamps
    end
  end
end
