class CreateEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :empresas do |t|
      t.string :imgLogo
      t.string :imgLogoAlt
      t.string :name
      t.text :description
      t.float :mapLon
      t.float :mapLat
      t.references :tag, foreign_key: true
      t.references :offer, foreign_key: true
      t.string :schedule
      t.string :direction
      t.string :web
      t.string :email
      t.string :tel
      t.references :user, foreign_key: true
      t.references :photo, foreign_key: true
      t.string :video

      t.timestamps
    end
  end
end
