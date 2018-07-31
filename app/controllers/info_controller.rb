class InfoController < ApplicationController
  before_action :set_region, except: [:publica, :preguntasfrecuentes, :publicitate, :consiguemascreditos]
  before_action :authenticate_user!, only: :consiguemascreditos

  def historia
    render "cities/#{@city}/historia.html.erb"
  end

  def turismo
    render "cities/#{@city}/turismo.html.erb"
  end

  def turismoactivo
    render "cities/#{@city}/turismoactivo.html.erb"
  end

  def alojamiento
    render "cities/#{@city}/alojamiento.html.erb"
  end

  def gastronomia
    render "cities/#{@city}/gastronomia.html.erb"
  end

  def naturaleza
    render "cities/#{@city}/naturaleza.html.erb"
  end

  def ocio
    render "cities/#{@city}/ocio.html.erb"
  end

  def guiaturistico
    render "cities/#{@city}/guiaturistico.html.erb"
  end

  def agradecimientos
    render "cities/#{@city}/agradecimientos.html.erb"
  end

  def publica

  end

  def preguntasfrecuentes
  end

  def publicitate

  end

  def cookies

  end

  def privacidad

  end
  
  def novedades

  end


  def condicionesdeuso

  end

  def precios
    if Config.first.promo_active == true
      flash.now[:notice] = Config.first.promo_text
    end

  end
  def consiguemascreditos
    @user = current_user
    @proposals = AchievementProposal.all
  end

  private
  def set_region
    @city = helpers.current_city
  end


end
