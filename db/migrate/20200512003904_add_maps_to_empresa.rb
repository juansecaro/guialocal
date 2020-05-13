class AddMapsToEmpresa < ActiveRecord::Migration[5.1]
  def change
    remove_column :empresas, :mlat, :float
    remove_column :empresas, :mlon, :float
    add_column :empresas, :map_string, :string, default: ''
  end
end
