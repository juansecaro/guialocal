class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :info
      t.references :user, foreign_key: true
      t.references :incident, foreign_key: true

      t.timestamps
    end
  end
end
