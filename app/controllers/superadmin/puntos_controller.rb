class Superadmin::PuntosController < Superadmin::ApplicationController
  before_action :set_punto, only: [:edit, :update, :destroy]
  def index
    @puntos = Punto.all
  end

  def new
    @punto = Punto.new
  end


  def create
    @punto = Punto.new(punto_params)

    respond_to do |format|
      if @punto.save
        format.html { redirect_to @punto, notice: 'El punto se ha creado con éxito' }
        format.json { render :show, status: :created, location: @punto }
      else
        format.html { render :new }
        format.json { render json: @punto.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @punto.update(punto_params)
        format.html { redirect_to superadmin_puntos_path, notice: 'El punto se ha actualizado con éxito' }
        format.json { render :show, status: :ok, location: @punto }
      else
        format.html { render :edit }
        format.json { render json: @punto.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @punto.destroy
    respond_to do |format|
      format.html { redirect_to superadmin_puntos_path, notice: 'Punto eliminado.' }
      format.json { head :no_content }
    end
  end

  private
  def set_punto
    @punto = Punto.friendly.find(params[:id])
  end
  def punto_params
    params.require(:punto).permit(:title, :subtitle, :description, :video, :mlon, :mlat, :schedule, :price, :info, {fotospunto:[]} )
  end
end
