class Superadmin::EmpresasController < Superadmin::ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]

  def index
    @empresas = Empresa.all.order(name: :asc)
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
    @empresa.destroy
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
    @empresa = Empresa.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.alert = "Le empresa que buscas no está aquí"
    redirect_to empresas_path
  end

  def empresa_params
    params.require(:empresa).permit(:logo, :name, :tag_list ,:category_id, :description, :plan, :mlon, :mlat, :address, :excerpt, :web, :email, :tel, :video, {fotos:[]}, :schedule0, :schedule1, :schedule2, :schedule3, :schedule4, :schedule5, :schedule6,
       :schedule7, :schedule8, :schedule9, :schedule10, :schedule11, :schedule12, :schedule13, :schedule14, :schedule15, :schedule16, :schedule17, :schedule18, :schedule19, :schedule20, :schedule21, :schedule22, :schedule23, :schedule24, :schedule25, :schedule26, :schedule27, :remove_logo)
  end

end
