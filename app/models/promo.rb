class Promo < ApplicationRecord
  belongs_to :empresa
  validates :titulo, presence: true, length:{ maximum: 32 }
  validates :texto, presence: true, length:{ maximum: 250 }
end
