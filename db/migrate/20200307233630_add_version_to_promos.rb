class AddVersionToPromos < ActiveRecord::Migration[5.1]
  def change
    add_column :promos, :version, :integer, default: 0
  end
end
