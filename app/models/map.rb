class Map < ApplicationRecord
  before_destroy :clean_s3

  mount_uploader :imgsrc, ImgsrcUploader

  extend FriendlyId
  friendly_id :title, use: :slugged

  def clean_s3
    self.remove_imgsrc!
  rescue Excon::Errors::Error => error
    puts "Couldn't be removed"
    false
  end
end
