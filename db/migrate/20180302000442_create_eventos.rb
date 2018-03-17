class CreateEventos < ActiveRecord::Migration[5.0]
  def change
    create_table :eventos do |t|
      t.string :titulo
      t.text :info
      t.string :img
      t.datetime :fecha

      t.timestamps
    end
  end
end
