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

end
