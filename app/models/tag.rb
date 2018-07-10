class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :empresas, through: :taggings

  extend FriendlyId
  friendly_id :name, use: :slugged

  def to_s
    name
  end

end
