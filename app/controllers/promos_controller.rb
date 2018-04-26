class PromosController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]

  def new
    @promo = Promo.new
  end

  def create
    @promo = Promo.new(promo_params)
    @promo.empresa_id = current_user.empresa_id
    valid_value = false
    #Faltan restar los créditos
    if params[:customRadioInline] == "baja"
      if current_user.creditos > 5
        current_user.creditos -= 5
        valid_value = true
        @promo.validez = Time.now + 1.day
      else
        flash.now[:error] = "Error: No tienes suficiente crédito."
        render 'new'
      end
    elsif params[:customRadioInline] == "media"
      if current_user.creditos > 7
        current_user.creditos -= 7
        valid_value = true
        @promo.validez = Time.now + 3.day
      else
        flash.now[:error] = "Error: No tienes suficiente crédito."
        render 'new'
      end
    elsif params[:customRadioInline] == "alta"
      if current_user.creditos > 10
        current_user.creditos -= 10
        valid_value = true
        @promo.validez = Time.now + 7.day
      else
        flash.now[:error] = "Error: No tienes suficiente crédito."
        render 'new'
      end
    else
      # Params no viene con ninguna de las opciones que buscamos
      render 'new', alert: "Error. Probablemente no se marcó marcó una opción valida en la duración"
    end

    if valid_value == true
      current_user.save!
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
