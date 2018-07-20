class Promo < ApplicationRecord
  belongs_to :empresa

  validates :titulo, presence: true, length:{ maximum: 60, too_long: "El título no puede ser mayor de 50 carácteres y tienes %{count}" }
  validates :texto, presence: true, length:{ maximum: 250, too_long: "El texto no puede ser mayor de  250 carácteres y tienes %{count}" }

  mount_uploader :imgpromo, ImgpromoUploader
  default_scope {order(created_at: :desc)}
  scope :activas, -> { where("validez > ?", Time.now).order("created_at ASC")  }
  scope :todas_diez_dias, -> { where("created_at > ?", Time.now-10.days).order("created_at DESC") }

end
