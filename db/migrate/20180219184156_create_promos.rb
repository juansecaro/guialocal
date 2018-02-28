class CreatePromos < ActiveRecord::Migration[5.0]
  def change
    create_table :promos do |t|
      t.string :titulo
      t.string :texto
      t.string :img
      t.datetime :validez
      t.references :empresa, foreign_key: true

      t.timestamps
    end
  end
end
