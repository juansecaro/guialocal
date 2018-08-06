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
    I18n.l(datetime, format: '%A') + datetime.strftime(", %d %b %Y %H:%M")
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
    else
      $current_city
    end

  end

  def current_city_capitalized
    if (current_city)
      return $current_city.capitalize
    end
  end

  def ga_script
    tracking_id = "UA-123191480-1"
    if Rails.env.production?
      javascript_tag("(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)})(window,document,'script','//www.google-analytics.com/analytics.js','ga');ga('create', '#{tracking_id}', 'auto');")
    end
  end

  def ga_track
    javascript_tag("if(window.ga != undefined){ga('send', 'pageview');}")
  end


end
