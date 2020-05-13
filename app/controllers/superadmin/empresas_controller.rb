class Superadmin::EmpresasController < Superadmin::ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]

  def index
    @empresas = Empresa.all.order(name: :asc)
  end

  # GET /empresas/new
  def new
    @empresa = Empresa.new
    @user_id = params[:user_id]
  end
  # POST /empresas
  # POST /empresas.json
  def create
    @empresa = Empresa.new(empresa_params)
    user_id = params[:user_id].to_i
    if user_id > 0 #Given n0 is admin and "" could be interpreted as 0, we avoid the risk
      @empresa.user_id = user_id
    end
    respond_to do |format|
      if @empresa.save
        helpers.set_current_empresa(@empresa.user, @empresa.id)
        format.html { redirect_to @empresa, notice: 'Empresa creada con éxito.' }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { render :new }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        format.html { redirect_to @empresa, notice: 'Empresa actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @empresa }
      else
        format.html { render :edit }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    user = @empresa.user
    @empresa.destroy
    user.current_empresa = user.empresas.first.id
    user.save!
    respond_to do |format|
      format.html { redirect_to superadmin_empresas_path, notice: 'Empresa eliminada con éxito.' }
      format.json { head :no_content }
    end
  end

  private

  def remove_logo_confirmed
    @empresa.remove_logo!
    @empresa.save!
  end

  def set_empresa
    @empresa = Empresa.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "Le empresa que buscas no está aquí"
    redirect_to empresas_path
  end

  def empresa_params
    params.require(:empresa).permit(:logo, :user_id, :name, :tag_list, :category_id, :description, :map_string, :plan, :address, :excerpt, :web, :email, :tel, :video, {fotos:[]}, :schedule0, :schedule1, :schedule2, :schedule3, :schedule4, :schedule5, :schedule6,
       :schedule7, :schedule8, :schedule9, :schedule10, :schedule11, :schedule12, :schedule13, :schedule14, :schedule15, :schedule16, :schedule17, :schedule18, :schedule19, :schedule20, :schedule21, :schedule22, :schedule23, :schedule24, :schedule25, :schedule26, :schedule27, :remove_logo)
  end



end
