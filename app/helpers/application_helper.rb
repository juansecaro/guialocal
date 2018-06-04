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


  def avatar_url(user)
    hash = Digest::MD5.hexdigest(user.email.downcase)
    "https://www.gravatar.com/avatar/#{hash}"
  end

  def time_format_mini(datetime)
    datetime.strftime("%A, %d %b %Y %H:%M")
  end

  def time_format_mini_mini(datetime)
    datetime.strftime("%d %b %Y %H:%M")
  end

  def full_title(page_title = "")
    default_title = "Guia #{$current_city} - Turismo y Empresas"
    if page_title.empty?
      default_title
    else
      "#{page_title} | #{default_title}"
    end
  end


  def current_city
    if ($current_city == "sinasignar" || $current_city == nil)
      $current_city = Config.first.city
      if $current_city == "sinasignar"
        flash[:alert] = "No hay una ciudad correctamente asignada al servidor"
      end
    else
      $current_city
    end

  end



end
