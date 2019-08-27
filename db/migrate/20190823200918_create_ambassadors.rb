class CreateAmbassadors < ActiveRecord::Migration[5.1]
  def change
    create_table :ambassadors do |t|
      t.string :name
      t.string :slug
      t.string :picture
      t.integer :country
      t.integer :language
      t.string :bio_original
      t.string :bio_english
      t.string :bio_native
      t.text :review_original
      t.text :review_english
      t.text :review_native
      t.string :video_interview
      t.string :video_testimonial

      t.timestamps
    end
    add_index :ambassadors, :slug, unique: true
  end
end
