module PromosHelper
  def time_format(datetime)
    if (datetime-Time.now) > 0
      "Aún tienes " + distance_of_time_in_words_to_now(datetime)
    else
      "La promoción ha terminado"
    end
  end

  def time_format_mini(datetime)
    datetime.strftime("%A, %d %b %Y %H:%M")
  end

end
