class InfoController < ApplicationController
  before_action :set_region, except: [:publica, :preguntasfrecuentes, :publicitate, :consiguemascreditos]

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

  def publica
  end

  def preguntasfrecuentes
  end

  def publicitate

  end
  def precios

  end
  def consiguemascreditos

  end

  private
  def set_region
    @city = helpers.current_city
  end


end
