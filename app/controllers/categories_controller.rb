class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  def show

  end
  def index
    @categories = Category.order(name: :asc)
  end
  private
  def set_category
    @category = Category.friendly.find(params[:id])
    #Si no lo encuentra
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "La categoría que buscas no existe"
    redirect_to (request.referrer || categories_path)
  end
end
