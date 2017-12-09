class Empresa < ApplicationRecord
  belongs_to :user
  has_many :offers, dependent: :destroy

  has_many :taggings, dependent: :destroy
  has_many :tag, through: :taggings

  mount_uploader :img_logo, ImgLogoUploader

  mount_uploaders :fotos, FotosUploader
  serialize :fotos, JSON # If you use SQLite, add this line
end
