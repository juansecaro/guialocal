class CreateIncidents < ActiveRecord::Migration[5.0]
  def change
    create_table :incidents do |t|
      t.string :subject
      t.text :info
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
