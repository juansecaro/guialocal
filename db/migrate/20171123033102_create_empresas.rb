class CreateEmpresas < ActiveRecord::Migration[5.0]
  def change
    create_table :empresas do |t|
      t.string :logo
      t.string :name

      t.text :description
      t.text :excerpt
      t.string :address
      t.string :web
      t.string :email
      t.string :tel
      t.string :video
      t.json :fotos

      t.integer :plan, default: 0
      t.float :mlon
      t.float :mlat

      t.string :schedule0, default: nil
      t.string :schedule1, default: nil
      t.string :schedule2, default: nil
      t.string :schedule3, default: nil
      t.string :schedule4, default: nil
      t.string :schedule5, default: nil
      t.string :schedule6, default: nil
      t.string :schedule7, default: nil
      t.string :schedule8, default: nil
      t.string :schedule9, default: nil
      t.string :schedule10, default: nil
      t.string :schedule11, default: nil
      t.string :schedule12, default: nil
      t.string :schedule13, default: nil
      t.string :schedule14, default: nil
      t.string :schedule15, default: nil
      t.string :schedule16, default: nil
      t.string :schedule17, default: nil
      t.string :schedule18, default: nil
      t.string :schedule19, default: nil
      t.string :schedule20, default: nil
      t.string :schedule21, default: nil
      t.string :schedule22, default: nil
      t.string :schedule23, default: nil
      t.string :schedule24, default: nil
      t.string :schedule25, default: nil
      t.string :schedule26, default: nil
      t.string :schedule27, default: nil

      t.integer  :tag_id
      t.integer  :offer_id
      t.integer  :user_id

      t.timestamps
    end
  end
end
