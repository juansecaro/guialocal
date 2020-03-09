class AddVersionToEventos < ActiveRecord::Migration[5.1]
  def change
    add_column :eventos, :version, :integer, default: 0
  end
end
