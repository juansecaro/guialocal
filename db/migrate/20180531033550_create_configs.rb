class CreateConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :configs do |t|
      t.integer :city
      t.json :map_levels, null: false, default: '{}'

      t.timestamps
    end
  end
end
