class RemoveConstraintFromUsers < ActiveRecord::Migration[5.0]
  def change
      remove_foreign_key :users, :empresas
      remove_column :users, :empresa_id
  end
end
