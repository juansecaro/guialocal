class AddPromoToPrices < ActiveRecord::Migration[5.0]
  def change
    add_column :configs, :promo_text, :string, default: ""
    add_column :configs, :promo_active, :boolean, default: false
  end
end
