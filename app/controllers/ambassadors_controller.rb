class AmbassadorsController < ApplicationController

  def index
    @ambassadors = Ambassador.all
  end

  def show
    @ambassador = Ambassador.friendly.find(params[:id])
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
