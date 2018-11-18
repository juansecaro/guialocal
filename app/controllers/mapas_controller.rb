class MapasController < ApplicationController
  before_action :set_map

  def index

    site ||= "Guia#{$current_city.capitalize}.es"

    set_meta_tags title: "Mapas turísticos e interactivos de Llerena y de la Campiña Sur de Extremadura",
                site: site,
                reverse: true,
                description: "Información turística de Llerena y la Campiña Sur en formato de mapa interactivo que muestra sitios como La Jayona, Regina, Castillo de Reina y Villagarcía, Observatorio de Aves, etc",
                keywords: "Mapa turismo rural llerena campiña sur Extremadura",

                twitter: {
                  card: "summary",
                  site: site,
                  title: "Mapas turísticos e interactivos de Llerena y de la Campiña Sur de Extremadura",
                  description: "Información turística de Llerena y la Campiña Sur en formato de mapa interactivo que muestra sitios como La Jayona, Regina, Castillo de Reina y Villagarcía, Observatorio de Aves, etc",
                  image: @map.imgsrc.url
                },

                og: {
                  title:    "Mapas turísticos e interactivos de Llerena y de la Campiña Sur de Extremadura",
                  description: "Información turística de Llerena y la Campiña Sur en formato de mapa interactivo que muestra sitios como La Jayona, Regina, Castillo de Reina y Villagarcía, Observatorio de Aves, etc",
                  type:     'website',
                  url:      mapas_path,
                  image:    @map.imgsrc.url
                }

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
