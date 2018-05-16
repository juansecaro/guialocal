class Promo < ApplicationRecord
  belongs_to :empresa

  validates :titulo, presence: true, length:{ maximum: 50, too_long: "El título no puede ser mayor de 32 carácteres y tienes %{count}" }
  validates :texto, presence: true, length:{ maximum: 250, too_long: "El texto no puede ser mayor de  250 carácteres y tienes %{count}" }

  mount_uploader :imgpromo, ImgpromoUploader
  scope :activas, -> { where("validez > ?", Time.now).order("created_at ASC")  }
  scope :todas_dos_semanas, -> { where("created_at > ?", Time.now-2.weeks).order("created_at DESC") }

end
