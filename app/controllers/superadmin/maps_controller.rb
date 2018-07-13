class Superadmin::MapsController < Superadmin::ApplicationController
  before_action :set_map, only: [:show, :edit, :update, :destroy]
  def index
    @maps = Map.all
  end

  def new
    @map = Map.new
  end

  def show

  end

  def create
    @map = Map.new(map_params)

    respond_to do |format|
      if @map.save
        format.html { redirect_to @map, notice: 'El mapa se ha creado con éxito' }
        format.json { render :show, status: :created, location: @map }
      else
        format.html { render :new }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @map.update(map_params)
        format.html { redirect_to superadmin_maps_path, notice: 'El mapa se ha actualizado con éxito' }
        format.json { render :show, status: :ok, location: @map }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to superadmin_maps_path, notice: 'Mapa eliminado.' }
      format.json { head :no_content }
    end
  end

  private
  def set_map
    @map = Map.find(params[:id])
  end
  def map_params
    params.require(:map).permit(:imgsrc, :body, :level)
  end
end
