class PromosController < ApplicationController
  def index
    @promos = Promo.all
    #@promos = Promo.where("created_at > ?", Time.now-7.days)
  end
  def show
    @promo = Promo.find(params[:id])
  end
end
