class Promo < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :empresa
  before_destroy :clean_s3, prepend: true

  attr_accessor :validezElegida


  validates :titulo, presence: true, length:{ maximum: 60, too_long: "El título no puede ser mayor de 50 carácteres y tienes %{count}" }
  validates :texto, presence: true, length:{ maximum: 250, too_long: "El texto no puede ser mayor de  250 carácteres y tienes %{count}" }
  validates :validezElegida, :presence => { :if => 'validez.nil?', message: ". Tienes que seleccionar la duración de la promoción" }
  #validates :validezElegida, presence: { message: ". Tienes que seleccionar la duración de la promoción"}, unless: -> { validez.nil? }
  # validates :validezElegida, presence: true, unless: -> { validez.nil? } for 5.2
  validates :normal_price, presence: { message: "La oferta debe llevar un precio" }, numericality: {greater_than: 0}
  validate :discount


  mount_uploader :imgpromo, ImgpromoUploader
  default_scope {order(created_at: :desc)}
  scope :activas, -> { where("validez > ?", Time.now).order("created_at ASC")  }
  scope :todas_diez_dias, -> { where("created_at > ?", Time.now-10.days).order("created_at DESC") }

  def as_json options={}
  {
    titulo: titulo,
    texto: texto,
    validez: distance_of_time_in_words_to_now(validez),
    imgpromo: imgpromo,
    created_at: created_at,
    normal_price: normal_price,
    special_price: special_price,
    logo: self.empresa.logo.url,
    address: self.empresa.address
  }
end


  private
  def clean_s3
    self.remove_imgpromo!
  rescue Excon::Errors::Error => error
    puts "Something gone wrong"
    false
  end

  def discount
    if (self.special_price.is_a?Numeric) && (self.special_price >= normal_price)
      errors.add(:Precio_rebajado, ".Si pones precio rebajado debe ser menor que el precio original")
    end
  end


end
