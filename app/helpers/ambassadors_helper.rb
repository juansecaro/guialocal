module AmbassadorsHelper
  def country_to_spanish(country)
    case country
    when "spain"
      "Espala"
    when "portugal"
      "Portugal"
    when "england"
      "Inglaterra"
    when "bulgaria"
      "Bulgaria"
    when "czechia"
      "República Checa"
    when "ukraine"
      "Ucrania"
    when "france"
      "Francia"
    when "germany"
      "Alemania"
    when "egypt"
      "Egipto"
    when "russia"
      "Rusia"
    when "greece"
      "Grecia"
    when "hungary"
      "Hungría"
    when "italy"
      "Italia"
    when "lithuania"
      "Lituania"
    when "macedonia"
      "Macedonia"
    when "malta"
      "Malta"
    when "poland"
      "Polonia"
    when "romania"
      "Rumanía"
    when "serbia"
      "Serbia"
    when "slovenia"
      "Eslovenia"
    else
      "un lugar desconocido"
    end
  end

  def country_flag(country)
    case country
    when "spain"
      "https://upload.wikimedia.org/wikipedia/commons/9/9a/Flag_of_Spain.svg"
    when "portugal"
      "https://upload.wikimedia.org/wikipedia/commons/5/5c/Flag_of_Portugal.svg"
    when "england"
      "https://upload.wikimedia.org/wikipedia/commons/b/be/Flag_of_England.svg"
    when "bulgaria"
      "https://upload.wikimedia.org/wikipedia/commons/9/9a/Flag_of_Bulgaria.svg"
    when "czechia"
      "https://upload.wikimedia.org/wikipedia/commons/c/cb/Flag_of_the_Czech_Republic.svg"
    when "ukraine"
      "https://upload.wikimedia.org/wikipedia/commons/4/49/Flag_of_Ukraine.svg"
    when "france"
      "https://upload.wikimedia.org/wikipedia/commons/c/c3/Flag_of_France.svg"
    when "germany"
      "https://upload.wikimedia.org/wikipedia/commons/b/ba/Flag_of_Germany.svg"
    when "egypt"
      "https://upload.wikimedia.org/wikipedia/commons/f/fe/Flag_of_Egypt.svg"
    when "russia"
      "https://upload.wikimedia.org/wikipedia/commons/f/f3/Flag_of_Russia.svg"
    when "greece"
      "https://upload.wikimedia.org/wikipedia/commons/5/5c/Flag_of_Greece.svg"
    when "hungary"
      "https://upload.wikimedia.org/wikipedia/commons/c/c1/Flag_of_Hungary.svg"
    when "italy"
      "https://upload.wikimedia.org/wikipedia/en/0/03/Flag_of_Italy.svg"
    when "lithuania"
      "https://upload.wikimedia.org/wikipedia/commons/1/11/Flag_of_Lithuania.svg"
    when "macedonia"
      "https://upload.wikimedia.org/wikipedia/commons/7/79/Flag_of_North_Macedonia.svg"
    when "malta"
      "https://upload.wikimedia.org/wikipedia/commons/7/73/Flag_of_Malta.svg"
    when "poland"
      "https://upload.wikimedia.org/wikipedia/en/1/12/Flag_of_Poland.svg"
    when "romania"
      "https://upload.wikimedia.org/wikipedia/commons/7/73/Flag_of_Romania.svg"
    when "serbia"
      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Serbia.svg/320px-Flag_of_Serbia.svg.png"
    when "slovenia"
      "https://upload.wikimedia.org/wikipedia/commons/f/f0/Flag_of_Slovenia.svg"
    else
      ""
    end
  end

  def english_herhis(ambassador)
    if ambassador.gender == "male"
      "his"
    else
      "her"
    end
  end

  def english_shehe(ambassador)
    if ambassador.gender == "male"
      "he"
    else
      "she"
    end
  end

end
