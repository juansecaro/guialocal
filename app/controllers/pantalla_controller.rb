class PantallaController < ApplicationController

  def index
    @config = Config.first
    @pantalla_number = params[:number]
    render layout: "pantalla"
  end

  def get_config
    @config = Config.first
    render json: @config
  end

  def update_status
    number = params[:number]
    @node = Node.find_by_number(number)
    if (!@node.nil?)
      @node.touch
      @node.save
      render json: {"status":"received"}
    else
      render json: {"status":"unreached"}
    end
  end

  def random_touristic_points
    @puntos = Destacado.all.order(Arel.sql('random()'))
    render json: @puntos
  end

  #Cogemos elementos válidos Y nos aseguramos de no coger lo que ya hemos mandado antes (last time), initially 0
  def lastest_events
    last_time_milliseconds = params[:last_events_retrieval].to_f
    if (last_time_milliseconds != 0)
      last_time = Time.at(last_time_milliseconds/1000)
      @eventos = Evento.where("fecha >= ? AND updated_at >= ?", Time.zone.now, last_time).order("fecha ASC")
    else
      @eventos = Evento.where("fecha >= ?", Time.zone.now).order("fecha ASC")
    end
    render json: @eventos
  end

  # if last_time_milliseconds is 0 it means is the first time is requested since is booted and hence, send all with validity
  def lastest_promos
    last_time_milliseconds = params[:last_promos_retrieval].to_f
    if (last_time_milliseconds != 0)
      last_time = Time.at(last_time_milliseconds/1000)
      @promos = Promo.where("validez >= ? AND updated_at >= ?", Time.zone.now, last_time).order("validez ASC")
    else
      @promos = Promo.where("validez >= ?", Time.zone.now).order("validez ASC")
    end
    #Rails.logger.info request.env['PATH_INFO']
    render json: @promos
  end

end
