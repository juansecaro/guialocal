class CreateAchievementProposals < ActiveRecord::Migration[5.0]
  def change
    create_table :achievement_proposals do |t|
      t.string :title
      t.text :info
      t.integer :reward

      t.timestamps
    end
  end
end
