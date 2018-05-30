class CreatePuntos < ActiveRecord::Migration[5.0]
  def change
    create_table :puntos do |t|
      t.string :title
      t.string :subtitle
      t.json :fotospunto
      t.text :description
      t.float :mlat
      t.float :mlon
      t.string :schedule
      t.float :price
      t.text :info
      t.text :video

      t.timestamps
    end
  end
end
