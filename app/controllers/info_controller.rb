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

  # def meta_tags (titulo, info)
  #   titulo ||= @evento.titulo
  #   site ||= "Guia#{$current_city.capitalize}.es"
  #   info ||= Nokogiri::HTML(@evento.info).text.truncate(255, separator: ' ')
  #
  #   set_meta_tags title: titulo,
  #               site: site,
  #               reverse: true,
  #               description: info,
  #               keywords: info,
  #
  #               twitter: {
  #                 card: "summary",
  #                 site: site,
  #                 title: titulo + " | " + site,
  #                 description:  info,
  #                 image: @evento.imgevento.url
  #               },
  #
  #               og: {
  #                 title:    titulo + " | " + site,
  #                 description: info,
  #                 type:     'article',
  #                 url:      evento_url(@evento),
  #                 image:    @evento.imgevento.url
  #               }
  # end


end
