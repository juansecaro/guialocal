class PromosController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]

  def new
    @promo = Promo.new
  end

  def create
    @promo = Promo.new(promo_params)
    @promo.empresa_id = current_user.empresa_id
    if params[:customRadioInline1] == "on"
      @promo.validez = Time.now + 1.day
    elsif params[:customRadioInline2] == "on"
      #byebug
      @promo.validez = Time.now + 3.days
    elsif params[:customRadioInline3] == "on"
      @promo.validez = Time.now + 7.days
    else
      render 'new', alert: "No se marcó marcó una opción valida en la duración"
    end



    respond_to do |format|
      if @promo.save
        # Restamos lo que sea
        format.html { redirect_to @promo, notice: 'La promoción se ha creado con éxito' }
        format.json { render :show, status: :created, location: @promo }
      else
        format.html { render :new }
        format.json { render json: @promo.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit

  end

  def update

  end

  def destroy

  end
  def mispromos
    @pasadas = Promo.where("validez <= ? AND empresa_id = ?", Time.now, current_user.empresa_id).order("created_at DESC")
    @actuales = Promo.where("validez > ? AND empresa_id = ?", Time.now, current_user.empresa_id).order("created_at DESC")
  end

  def index
    @promos = Promo.todas_dos_semanas
    #@promos = Promo.where("created_at > ?", Time.now-7.days)
  end
  def show
    @promo = Promo.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promo
      @promo = Promo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promo_params
      params.require(:promo).permit(:titulo, :imgpromo, :texto, :validez)
    end

end
