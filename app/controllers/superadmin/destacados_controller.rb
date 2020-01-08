class Superadmin::DestacadosController < Superadmin::ApplicationController
  before_action :set_destacado, only: [:show, :edit, :update, :destroy]
  def index
    @destacados = Destacado.all
  end

  def new
    @destacado = Destacado.new
  end

  def create
    @destacado = Destacado.new(destacado_params)
    respond_to do |format|
      if @destacado.save
        format.html { redirect_to superadmin_destacados_path, notice: 'Destacado creado con éxito.' }
        format.json { render :index, status: :created, location: @destacado }
      else
        format.html { render :new }
        format.json { render json: @destacado.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

  end

  def edit
  end

  def update
    if @destacado.update(destacado_params)
      flash[:notice] = "Destacado editado con éxito."
      redirect_to superadmin_destacados_path
    else
      flash.now[:alert] = "Hubo un problema. No se pudo actualizar el destacado."
      render 'edit'
    end
  end
  def destroy
    @destacado.imgdestacado.remove!
    FileUtils.remove_dir("#{Rails.root}/public/uploads/#{ENV['CURRENT_CITY']}/destacado/imgdestacado/#{@destacado.id}", :force => true)
    @destacado.destroy
    flash[:alert] = "Se ha borrado el destacado."
    redirect_to superadmin_destacados_path
  end

  private
  def destacado_params
    params.require(:destacado).permit(:titulo, :info, :imgdestacado)
  end
  def set_destacado
    @destacado = Destacado.find(params[:id])
  end


end
