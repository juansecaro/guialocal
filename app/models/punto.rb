class Punto < ApplicationRecord

  mount_uploaders :fotospunto, FotospuntoUploader

  extend FriendlyId
  friendly_id :title, use: :slugged
end
