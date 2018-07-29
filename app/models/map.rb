class Map < ApplicationRecord

  mount_uploader :imgsrc, ImgsrcUploader

  extend FriendlyId
  friendly_id :title, use: :slugged
end
