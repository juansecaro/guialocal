class RemoveAdsFromConfigs < ActiveRecord::Migration[5.1]
  def change
    remove_column :configs, :happyhour, :boolean
    remove_column :configs, :promo_active, :boolean
    remove_column :configs, :promo_text, :string
  end
end
