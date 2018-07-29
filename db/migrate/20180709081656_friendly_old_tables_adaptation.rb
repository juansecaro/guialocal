class FriendlyOldTablesAdaptation < ActiveRecord::Migration[5.0]
  def change
    add_column :empresas, :slug, :string, unique: true
    add_column :categories, :slug, :string, unique: true
    add_column :tags, :slug, :string, unique: true
    add_column :eventos, :slug, :string, unique: true
    add_column :puntos, :slug, :string, unique: true
    add_column :maps, :slug, :string, unique: true
  end
end
