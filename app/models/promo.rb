class Promo < ApplicationRecord
  belongs_to :empresa
  validates :titulo, presence: true, length:{ maximum: 32 }
  validates :texto, presence: true, length:{ maximum: 250 }
  mount_uploader :imgpromo, ImgpromoUploader
  scope :activas, -> { where("validez > ?", Time.now).order("created_at ASC")  }
  scope :todas_dos_semanas, -> { where("created_at > ?", Time.now-2.weeks).order("created_at DESC") }
end
