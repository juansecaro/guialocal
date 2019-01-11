class AddEmpresaToSuscriptor < ActiveRecord::Migration[5.0]
  def change
    add_column :suscriptors, :empresa_id, :integer
  end
end
