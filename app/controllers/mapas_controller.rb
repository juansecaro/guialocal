class MapasController < ApplicationController
  before_action :set_map

  def index
    flash.now[:notice] = "Es un mapa interactivo: clica en los dibujos para obtener información"
  end

  def show
  end

  def set_map
    if (params[:id]==nil)
      map_id = Map.find_by_level("1_1").id
      @map = Map.friendly.find(map_id)
    else
      @map = Map.friendly.find(params[:id])
    end
  end
end
