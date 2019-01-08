class Superadmin::SuscriptorsController < Superadmin::ApplicationController

  before_action :set_suscriptor, except: :index
  def index
    @suscriptors = Suscriptor.all
  end

  def show

  end

  def edit

  end

  def update
    respond_to do |format|
      if @suscriptor.update(suscriptor_params)
        format.html { redirect_to superadmin_suscriptors_path, notice: 'El suscriptor se ha actualizado con éxito' }
        format.json { render :show, status: :ok, location: @suscriptor }
      else
        format.html { render :edit }
        format.json { render json: @suscriptor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @suscriptor.destroy
    respond_to do |format|
      format.html { redirect_to superadmin_suscriptors_path, notice: 'Suscriptor eliminado.' }
      format.json { head :no_content }
    end
  end


  private
  def set_suscriptor
    @suscriptor = Suscriptor.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "El suscriptor que buscas no existe"
    redirect_to (request.referrer || root_path)
  end

  def suscriptor_params
    params.require(:suscriptor).permit(:email, :email_confirmation)
  end
end
