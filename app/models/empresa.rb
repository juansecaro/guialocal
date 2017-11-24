class Empresa < ApplicationRecord
  has_many :offers
  has_many :photos, dependent: :destroy
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :empresas, through: :taggings

  mount_uploader :img_logo, ImgLogoUploader

end
