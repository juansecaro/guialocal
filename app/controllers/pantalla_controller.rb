class PantallaController < ApplicationController

  def index
    #eventos = Evento.where("fecha >= ?", Time.zone.now).order("created_at DESC")
    #promos = Promo.where("validez >= ?", Time.zone.now).order("created_at DESC")
    #puntos = Punto.all

    #last_config = [2, 3, 3]

    render layout: "pantalla"
  end

  def lastest_events
    last_time_milliseconds = params[:last_events_retrieval].to_f
    last_time = Time.at(last_time_milliseconds/1000)
    @eventos = Evento.where("fecha <= ?", Time.zone.now).order("created_at ASC")
    #no olvides cambiar el <
    render json: @eventos
  end

  def lastest_promos
    last_time_milliseconds = params[:last_promos_retrieval].to_f
    last_time = Time.at(last_time_milliseconds/1000)
    @promos = Promo.where("validez <= ?", Time.zone.now).order("created_at ASC")
    render json: @promos
  end

  private

end
