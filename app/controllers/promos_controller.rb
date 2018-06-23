class PromosController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show ]
  #before_filter ->{ authenticate_user!( force: true ) }, only: [:index, :create, :mispromos]

  def new
    @promo = Promo.new
  end

  def create
    @promo = Promo.new(promo_params)
    @promo.empresa_id = current_user.empresa.id

      valid_value = false
      #nos aseguramos que el radiobutton corresponda con una de nuestras opciones
      if params[:customRadioInline] == "baja"
        if current_user.creditos > 5
          saldo = 5
          valid_value = true
          @promo.validez = Time.now + 1.day
        else
          flash.now[:error] = "Error: No tienes suficiente crédito."
          render 'new'
        end
      elsif params[:customRadioInline] == "media"
        if current_user.creditos > 7
          saldo = 7
          valid_value = true
          @promo.validez = Time.now + 3.day
        else
          flash.now[:error] = "Error: No tienes suficiente crédito."
          render 'new'
        end
      elsif params[:customRadioInline] == "alta"
        if current_user.creditos > 10
          saldo = 10
          valid_value = true
          @promo.validez = Time.now + 7.day
        else
          flash.now[:error] = "Error: No tienes suficiente crédito."
          render 'new'
        end
      end

  # Ya tenemos todo para saber si es válido o no
      if valid_value == true

          respond_to do |format|
            if @promo.save
              # Restamos lo que sea
              current_user.update_attributes(creditos: current_user.creditos -= saldo)
              format.html { redirect_to @promo, notice: 'La promoción se ha creado con éxito' }
              format.json { render :show, status: :created, location: @promo }
            else
              format.html { render :new, alert: @promo.errors }
              format.json { render json: @promo.errors, status: :unprocessable_entity }
            end
          end

      else
        flash.now[:error] = "Debes seleccionar al menos una opción."
        render 'new'
      end

  end

  def edit

  end

  def update

  end

  def destroy

  end
  def mispromos
    @pasadas = Promo.where("validez <= ? AND empresa_id = ?", Time.now, current_user.empresa.id).order("created_at DESC")
    @actuales = Promo.where("validez > ? AND empresa_id = ?", Time.now, current_user.empresa.id).order("created_at DESC")
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
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "La promoción que buscas no existe"
      redirect_to (request.referrer || root_path)
    end

    def verify_id!
        authenticate_user!
        unless (@promo.user == current_user)
          redirect_to root_path, alert: "No eres el propietario de esta empresa y no puedes operarla."
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promo_params
      params.require(:promo).permit(:titulo, :imgpromo, :texto, :validez)
    end

end
