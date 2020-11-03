module ApplicationHelper

  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  def admins_only(&block)
    block.call if (current_user.try(:admin?) || current_user.try(:superadmin?))
  end

  def superadmins_only(&block)
    block.call if current_user.try(:superadmin?)
  end

  def editors_only(&block)
    block.call if current_user.try(:editor?)
  end


  def avatar_url(user)
    hash = Digest::MD5.hexdigest(user.email.downcase)
    "https://www.gravatar.com/avatar/#{hash}"
  end

  def time_format_mini(datetime)
    I18n.l(datetime, format: '%A, %d de %B a las %H:%M')

  end

  def time_format_mini_mini(datetime)
    datetime.strftime("%d %b %Y %H:%M")
  end

  def full_title(page_title = "")
    default_title = "Guia#{current_city.capitalize} - Turismo y Empresas"
    if page_title.empty?
      default_title
    else
      "#{page_title} | #{default_title}"
    end
  end

  def current_city
    if ($current_city == "sinasignar" || $current_city == nil)
      $current_city = Config.first.city || "Dev"
    else
      $current_city
    end

  end

  def current_city_capitalized
    if (current_city)
      return $current_city.capitalize
    end
  end

  def money_format(price)
    return "0" if price == nil
    if price.is_a?(BigDecimal) && price > 0
      price = sprintf('%.2f', price)
      price_uds = price.split('.')[0]
      price_decimals = price.split('.')[1]
      price_uds = price_uds.reverse.scan(/.{1,3}/).join(".").reverse
      if price.chars.last(3).join == ".00"
        price = price_uds
      else
        price = price_uds + "," + price_decimals
      end
    end
    price
  end



end
