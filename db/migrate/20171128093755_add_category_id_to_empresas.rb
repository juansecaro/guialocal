class AddCategoryIdToEmpresas < ActiveRecord::Migration[5.0]
  def change
    add_column :empresas, :category_id, :integer
    add_index :empresas, :category_id
  end
end
