class CreateSuscriptors < ActiveRecord::Migration[5.0]
  def change
    create_table :suscriptors do |t|
      t.string :email
      t.boolean :email_confirmation, default: false
      t.string :token_confirmation

      t.timestamps
    end
  end
end
