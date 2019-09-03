class PantallaController < ApplicationController
  def index
    @eventos = Evento.where("fecha >= ?", Time.zone.now)
    @promos = Promo.where("validez >= ?", Time.zone.now).order("created_at DESC") 

    render layout: false
  end
end
