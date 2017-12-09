class CreateEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :empresas do |t|
      t.string :logo
      t.string :name

      t.text :description
      t.string :schedule
      t.string :address
      t.string :web
      t.string :email
      t.string :tel
      t.string :video
      t.string :fotos

      t.float :mlon
      t.float :mlat

      t.integer  :tag_id
      t.integer  :offer_id
      t.integer  :user_id

      t.timestamps
    end
  end
end
