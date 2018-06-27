class CreateAchievements < ActiveRecord::Migration[5.0]
  def change
    create_table :achievements do |t|
      #
      t.boolean :achievement0, default: false
      t.boolean :achievement1, default: false
      t.boolean :achievement2, default: false
      t.boolean :achievement3, default: false
      t.boolean :achievement4, default: false
      t.boolean :achievement5, default: false
      t.boolean :achievement6, default: false
      t.boolean :achievement7, default: false
      t.boolean :achievement8, default: false
      t.boolean :achievement9, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
