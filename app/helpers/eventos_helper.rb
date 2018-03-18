module EventosHelper
  def time_format_mini_evento(datetime)
    I18n.l(datetime, format: :short)
  end
end
