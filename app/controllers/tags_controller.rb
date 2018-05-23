class TagsController < ApplicationController
  before_action :set_tag, only: :show
  def show
  end
  def index
    @tags = Tag.all
  end


  private
  def set_tag
    @tag = Tag.find(params[:id])

    #Si no lo encuentra
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "La palabra clave que buscas no existe"
    redirect_to (request.referrer || tags_path)
  end
end
