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
    block.call if current_user.try(:admin?)
  end

  def time_format(datetime)
    #datetime.strftime('%H:%M') unless datetime.blank?
  end
  def now_is_between?(time1,time2)
    (time1.utc.strftime( "%H%M" ) <= Time.now.utc.strftime( "%H%M" )) && (Time.now.utc.strftime( "%H%M" ) < time2.utc.strftime( "%H%M" ))
  end

  def avatar_url(user)
  hash = Digest::MD5.hexdigest(user.email.downcase)
  "https://www.gravatar.com/avatar/#{hash}"
  end

  def full_title(page_title = "")
  default_title = "Eventsboard - Creare events for everybody"
  if page_title.empty?
    default_title
  else
    "#{page_title} | #{default_title}"
  end
  end
end
