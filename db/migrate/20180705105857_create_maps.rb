class CreateMaps < ActiveRecord::Migration[5.0]
  def change
    create_table :maps do |t|
      t.string :level
      t.string :imgsrc
      t.text :body

      t.timestamps
    end
  end
end
