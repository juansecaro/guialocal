class CreateDestacados < ActiveRecord::Migration[5.0]
  def change
    create_table :destacados do |t|
      t.string :imgdestacado
      t.text :info

      t.timestamps
    end
  end
end
