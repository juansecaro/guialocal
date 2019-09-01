class AmbassadorsController < ApplicationController

  def index
    @ambassadors = Ambassador.all
  end

  def show

    @ambassador = Ambassador.friendly.find(params[:id])

    titulo ||= @ambassador.name + " | International Ambassador for Llerena (SPAIN)"
    site ||= "Guia#{ENV['CURRENT_CITY_CAP']}.es"
    info = "Embajadores sin fronteras"

    set_meta_tags title: @ambassador.picture.url ,
                site: site,
                reverse: true,
                description: info,
                keywords: titulo,

                twitter: {
                  card: "summary",
                  site: site,
                  title: titulo + " | " + site,
                  description:  info,
                  image: @ambassador.picture.url
                },

                og: {
                  title:    titulo + " | " + site,
                  description: info,
                  type:     'article',
                  url:      "ambassador_path(@ambassador)",
                  image:    @ambassador.picture.url
                }

    #Si no lo encuentra
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "La embajador que buscas no existe"
    redirect_to (request.referrer || ambassadors_path)
  end

  def english
    @ambassador = Ambassador.find_by_slug(params[:name])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The ambassador you are looking for is not here, or not here anymore"
    redirect_to (request.referrer || ambassadors_path)
  end

  def native
    @ambassador = Ambassador.find_by_slug(params[:name])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The ambassador you are looking for is not here, or not here anymore"
    redirect_to (request.referrer || ambassadors_path)
  end

end
