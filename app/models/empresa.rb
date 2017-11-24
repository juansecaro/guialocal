class Empresa < ApplicationRecord
  has_many :offers
  has_many :photos
  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :empresas, through: :taggings

end
