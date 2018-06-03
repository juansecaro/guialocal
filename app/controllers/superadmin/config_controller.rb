class Superadmin::ConfigController < Superadmin::ApplicationController
  before_action :set_config

  def edit

  end

  def update
    if @config.update(config_params)
      helpers.change_current_city(params[:city])
      flash[:notice] = "Configuración actualizada"
      redirect_to superadmin_configs_path
    else
      flash.now[:alert] = "Hubo un problema. No se pudo actualizar la configuración."
      render 'edit'
    end
  end

  private
  def set_config
    @config = Config.first
  end
  def config_params
    params.require(:config).permit(:city)
  end
end
