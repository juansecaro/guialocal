class PromosController < ApplicationController
  def show
    @promo = Promo.find(params[:id])
  end
end
