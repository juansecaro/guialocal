module PromosHelper
  def time_format(datetime)
    if (datetime-Time.now) > 0
      "Aún tienes " + distance_of_time_in_words_to_now(datetime)
    else
      "La promoción ha terminado"
    end
  end

  def domain_base
    return "www.guia#{$current_city}.es"
  end

end
