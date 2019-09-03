class AddDetailsToAmbassadors < ActiveRecord::Migration[5.1]
  def change
    add_column :ambassadors, :partner_name, :string, default: nil
    add_column :ambassadors, :partner_profile, :string, default: nil
    add_column :ambassadors, :gallery, :json
    add_column :ambassadors, :gender, :integer
  end
end
