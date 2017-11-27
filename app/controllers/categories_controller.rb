class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  def show
    @categories = Category.all
  end
  private
  def set_category
    @category = Category.find(params[:id])

    #Si no lo encuentra
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "La categoría que buscas no existe"
    redirect_to (request.referrer || empresas_path)
  end
end
