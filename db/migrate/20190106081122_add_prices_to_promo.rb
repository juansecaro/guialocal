class AddPricesToPromo < ActiveRecord::Migration[5.0]
  def change
      add_column :promos, :normal_price, :decimal, default: nil
      add_column :promos, :special_price, :decimal, default: nil
  end
end
