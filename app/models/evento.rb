class Evento < ApplicationRecord

  mount_uploader :imgevento, ImgeventoUploader

  extend FriendlyId
  friendly_id :titulo, use: :slugged
end
