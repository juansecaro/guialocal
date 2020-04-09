class CreateNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :nodes do |t|
      t.integer :number
      t.string :address
      t.string :description

      t.timestamps
    end
  end
end
