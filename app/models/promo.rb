class Promo < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :empresa
  before_destroy :clean_s3, prepend: true

  attr_accessor :validezElegida

  validates :titulo, presence: true, length:{ maximum: 60, too_long: "El título no puede ser mayor de 50 carácteres y tienes %{count}" }
  validates :texto, presence: true, length:{ maximum: 250, too_long: "El texto no puede ser mayor de  250 carácteres y tienes %{count}" }


  validate :check_prices, :validez_elegida

  mount_uploader :imgpromo, ImgpromoUploader
  default_scope {order(created_at: :desc)}
  scope :activas, -> { where("validez > ?", Time.now).order("created_at ASC")  }
  scope :todas_diez_dias, -> { where("created_at > ?", Time.now-10.days).order("created_at DESC") }

  def as_json options={}
  {
    id: id,
    empresa_id: self.empresa.id,
    titulo: titulo,
    texto: texto,
    version: version,
    validez: distance_of_time_in_words_to_now(validez),
    imgpromo: imgpromo,
    validez_num: validez.to_time.to_i,
    updated_at: updated_at.to_time.to_i,
    normal_price: normal_price,
    special_price: special_price,
    logo: self.empresa.logo.url,
    address: self.empresa.address
  }
end

# Deletes daily invalid (erased promos)
def self.autodeletion
  Promo.where("DATE(validez) <= ? OR version = '-1'", Date.today.prev_day).destroy_all
end


private
def clean_s3
  self.remove_imgpromo!
rescue Excon::Errors::Error => error
  puts "Something gone wrong"
  false
end

def check_prices
  if (self.normal_price.nil?)
      errors.add(:base, "Tienes que poner un precio válido")
  elsif (self.normal_price == 0)
    if (self.special_price.is_a?Numeric)
      if (self.special_price > self.normal_price)
        errors.add(:base, "El precio rebajado no puede ser mayor que el original")
      end
    end
  else
    if (self.special_price.is_a?Numeric)
      if (self.special_price >= self.normal_price)
        errors.add(:base, "El precio rebajado tiene que ser menor que el original")
      end
    end
  end
end

def validez_elegida
  if validez.nil?
    errors.add(:base, "Tienes que seleccionar la duración de la promoción")
  end
end


end
