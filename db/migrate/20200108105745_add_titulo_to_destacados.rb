class AddTituloToDestacados < ActiveRecord::Migration[5.1]
  def change
    add_column :destacados, :titulo, :string
  end
end
