class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description
      t.references :photo, foreign_key: true

      t.timestamps
    end
  end
end
