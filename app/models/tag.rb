class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :empresas, through: :taggings

  def to_s
    name
  end
end
