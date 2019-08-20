class InfoController < ApplicationController
  before_action :set_region, except: [:publica, :preguntasfrecuentes, :publicitate, :consiguemascreditos, :cookies, :privacidad, :novedades, :condicionesdeuso]
  before_action :authenticate_user!, only: :consiguemascreditos
  invisible_captcha only: :quejasysugerencias, honeypot: :subtitle, on_spam: :spam_received


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
    site ||= "Guia#{ENV['CURRENT_CITY_CAP']}.es"
    desc = "Guía gastronómica de #{ENV['CURRENT_CITY_CAP']}. Para comer bien, para disfrutar comiendo."
    @city = helpers.current_city

    set_meta_tags title: desc,
                site: site,
                reverse: true,
                description: desc + " | " + site,

                twitter: {
                  card: "summary",
                  site: site,
                  title: desc,
                  description:  desc + " | " + site,
                  image: "#{$url_base}/cities/#{@city}/logo.jpg"
                },

                og: {
                  title:    site,
                  description: desc,
                  type:     'website',
                  url:      "#{root_url}/gastronomia",
                  image:    "#{$url_base}/cities/#{@city}/logo.jpg"
                }

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

  def salon_de_la_fama
    # We get all the suscriptor's references removing those who hasn't one
    suscriptors = Suscriptor.where.not(empresa_id: [nil,0]).where(email_confirmation: true)
    @empresas = []
    # We push each reference in an array as a Empresa_id
    suscriptors.each do |s|
      @empresas.push(s.empresa_id)
    end
    # We count the times each Empresa is refered, and show it ordered by the highest
    @index = @empresas.group_by(&:itself).transform_values(&:count).sort_by {|k,v| v}.reverse
  end

  def comparativa_promociones

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

  def condicionesdeuso

  end

  def quejasysugerencias
    @contact = Contact.new
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

  def spam_received
    redirect_to root_path
  end

end
