module PromosHelper

  def time_format(datetime)
    if (datetime-Time.now) > 0
      "Aún disponible " #+ distance_of_time_in_words_to_now(datetime)
    else
      "La promoción ha terminado"
    end
  end

  def domain_base
    return "www.guia#{$current_city}.es"
  end

  def discount(promo)
    if promo.normal_price?
      if promo.special_price?
        "-#{(((promo.normal_price-promo.special_price)/promo.normal_price)*100).round}%"
      end
    end
  end

  # We set using time.now when is the first time and hence, there is not one saved
  def set_validez_promo
    case params[:promo][:validez_elegida]
    when 'alta'
      @promo.created_at.nil? ? @promo.validez = Time.zone.now + 7.days : @promo.validez = @promo.created_at + 7.days
    when 'media'
      @promo.created_at.nil? ? @promo.validez = Time.zone.now + 3.days : @promo.validez = @promo.created_at + 3.days
    when 'baja'
      @promo.created_at.nil? ? @promo.validez = Time.zone.now + 1.day : @promo.validez = @promo.created_at + 1.days
    end
  end

end
