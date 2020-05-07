class CreateProspects < ActiveRecord::Migration[5.1]
  def change
    create_table :prospects, id: :uuid do |t|
      t.string :user_email
      t.string :dni
      t.integer :plan
      t.integer :original_plan
      t.string :status, default: 'created'
      t.string :empresa_name
      t.string :empresa_email
      t.integer :empresa_phone
      t.string :empresa_address
      t.string :empresa_web
      t.integer :empresa_category
      t.string :empresa_summary
      t.string :user_first_name
      t.string :user_last_name
      t.datetime :user_birthday
      t.string :user_phone
      t.string :user_address
      t.string :iban_code

      t.boolean :conditions_accepted, default: false
      t.string :ip_address
      t.datetime :date_of_acceptance

      t.timestamps
    end
  end
end
