class Empresa < ApplicationRecord

  belongs_to :user
  has_many :offers, dependent: :destroy
  has_many :photos, dependent: :destroy


  has_many :taggings, dependent: :destroy
  has_many :tag, through: :taggings

  mount_uploader :img_logo, ImgLogoUploader

end
