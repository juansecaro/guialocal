class CreateEventos < ActiveRecord::Migration[5.0]
  def change
    create_table :eventos do |t|
      t.text :info
      t.string :img
      t.string :titulo

      t.timestamps
    end
  end
end
