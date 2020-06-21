# frozen_string_literal: true
class PromosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :control_max_promos, only: :create
  before_action :set_promo, only: [:show, :edit, :update, :destroy]

  def new
    @plan = current_user.empresas.find_by_id(current_user.current_empresa).plan
    @promo = Promo.new
  end

  def create

    plan = current_user.empresas.find_by_id(current_user.current_empresa).plan

    if plan == 'noplan'
      flash[:error] = 'No puedas lanzar promociones. Tu plan está fuera de validez. Renuévalo.'
      redirect_to root_path
    else
      @promo = Promo.new(promo_params)
      @promo.empresa_id = current_user.current_empresa

      create_promo
    end
  end

  def edit
    if Time.now.utc > @promo.created_at + 1800
      flash[:error] = 'Sólo puedes editar promociones durante la primera media hora'
      redirect_to mispromos_path
    end
  end

  def update
    respond_to do |format|
      @promo.increment(:version)
      set_validez
      if @promo.update(promo_params)
        format.html { redirect_to mispromos_path, notice: 'La promoción se ha actualizado con éxito' }
        format.json { render :show, status: :ok, location: @promo }
      else
        format.html { render :edit }
        format.json { render json: @promo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @promo.imgpromo.remove!
    FileUtils.remove_dir("#{Rails.root}/public/uploads/#{ENV['CURRENT_CITY']}/promo/imgpromo/#{@promo.id}", force: true)
    @promo.destroy
  end

  def mispromos
    @empresa = current_user.empresas.find_by_id(current_user.current_empresa)
    @plan = @empresa.plan
    redirect_to root_path, alert: "No puedes poner promociones sin tener un plan anual o si está al día" and return unless @plan != "noplan"
    last_promo = @empresa.try(:promos).where("version >= '0'").try(:first)

    if @plan != 'premium'
      if !last_promo.nil?
        waiting = waiting_date(last_promo, @plan)
        @waiting = (waiting - Time.zone.now).to_i if waiting > Time.zone.now
      else
        @waiting = nil
      end
    end

    @pasadas = Promo.where('validez <= ? AND empresa_id = ? AND version >= 0', Time.zone.now, @empresa.id).order('created_at DESC')
    @actuales = Promo.where('validez > ? AND empresa_id = ? AND version >= 0', Time.zone.now, @empresa.id).order('created_at DESC')

    @ready = false

    case @plan
    when 'premium'
      if @actuales.count < 3
        @ready = true
      else
        if is_still_valid?(@actuales[0]) == false
          @ready = true # At least the last one isn' valid
        else
          @waiting = @actuales[0].validez.to_i - Time.zone.now.to_i
          flash.now[:notice] = 'Has llegado al límite máximo (3) de promociones simultáneas'
        end
      end
    when 'plus'
      return @ready = true if @waiting.nil?
    when 'basic'
      return @ready = true if @waiting.nil?
    end
  end

  def index
    @promos = Promo.todas_diez_dias.paginate(page: params[:page], per_page: 20)

    titulo ||= 'Ofertas flash semanales'
    site ||= "Guia#{ENV['CURRENT_CITY_CAP']}.es"
    info = 'Las mejores promociones y ofertas de la empresa local'

    set_meta_tags title: titulo,
                  site: site,
                  reverse: true,
                  description: info,
                  keywords: titulo,

                  twitter: {
                    card: 'summary',
                    site: site,
                    title: titulo + ' | ' + site,
                    description: info,
                    image: "#{$url_base}/cities/#{@city}/logo.jpg"
                  },

                  og: {
                    title: titulo + ' | ' + site,
                    description: info,
                    type: 'article',
                    url: ofertas_y_promociones_url,
                    image: "#{$url_base}/cities/#{@city}/logo.jpg"
                  }
  end

  def show
    flash.now[:notice] = 'Enséñale esto al comerciante para obtener tu descuento'
    @waiting = (@promo.validez - Time.zone.now).to_i
    # @saving = ((@promo.normal_price - @promo.special_price)/@promo.normal_price)*100

    titulo ||= 'Oferta flash: ' + @promo.titulo
    site ||= "Guia#{ENV['CURRENT_CITY_CAP']}.es"
    info ||= Nokogiri::HTML(@promo.texto).text.truncate(255, separator: ' ')

    set_meta_tags title: titulo,
                  site: site,
                  reverse: true,
                  description: info,
                  keywords: titulo,

                  twitter: {
                    card: 'summary',
                    site: site,
                    title: titulo + ' | ' + site,
                    description: info,
                    image: @promo.imgpromo.url
                  },

                  og: {
                    title: titulo + ' | ' + site,
                    description: info,
                    type: 'article',
                    url: promo_url(@promo),
                    image: @promo.imgpromo.url
                  }
  end



  private

  # Use callbacks to share common setup or constraints between actions.
  def set_promo
    @promo = Promo.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'La promoción que buscas no existe'
    redirect_to (request.referrer || root_path)
  end

  def control_max_promos
    # Delete the oldest when reach 20
    if current_user.empresas.find_by_id(current_user.current_empresa).promos.count > 19
      current_user.empresas.find_by_id(current_user.current_empresa).promos.order(created_at: :desc).last.destroy
    end
  end

  # We set using time.now when is the first time and hence, there is not one saved
  def set_validez
    case params[:promo][:validezElegida]
    when 'alta'
      @promo.created_at.nil? ? @promo.validez = Time.zone.now + 7.days : @promo.validez = @promo.created_at + 7.days
    when 'media'
      @promo.created_at.nil? ? @promo.validez = Time.zone.now + 3.days : @promo.validez = @promo.created_at + 3.days
    when 'baja'
      @promo.created_at.nil? ? @promo.validez = Time.zone.now + 1.day : @promo.validez = @promo.created_at + 1.days
    end
  end

  def is_still_valid?(promo)
    promo.validez > Time.zone.now
  end

  def create_promo
    #===========> Remember the promos are odered inversely so I take first (more recent one)
    valid_value = false
    empresa = current_user.empresas.find_by_id(current_user.current_empresa)
    when_last_promo = empresa.try(:promos).where("version >= '0'").try(:first).try(:created_at)
    plan = empresa.plan

    if when_last_promo.nil? # no previous publication
      valid_value = true
      set_validez
    else
      if plan == 'premium'
        last_promos = empresa.try(:promos).where("version >= '0'").try(:first, 3)
        if last_promos.count < 3
          valid_value = true
          set_validez
        else
          # It has 3 or more
          if is_still_valid?(last_promos[2]) # last and oldest element
            # All 3 options active, must wait until at least 1 finish validity
            flash.now[:error] = 'Tienes 3 promociones en activo (Máximo). Cuando acabe una podrás poner más.'
            render('new') && return
          else
            # We know not all 3 options are active, so we can activate a new one
            valid_value = true
            set_validez
          end
        end
      else
        # basic/plus
        last_promo_item = empresa.try(:promos).where("version >= '0'").try(:first)
        if is_still_valid?(last_promo_item)
          flash.now[:error] = 'Tu última publicación aún está activa (pásate a premium si quieres varias y sin esperas)'
          render('new') && return
        else
          # Has finished the waiting period?
          @waiting_until = waiting_date(last_promo_item, plan)
          if Time.zone.now > @waiting_until
            valid_value = true
            set_validez
          else
            flash.now[:error] = 'Aún tienes que esperar hasta la próxima promoción (pásate a premium si no quieres esperas)'
            render('new') && return
          end
        end
      end
    end

    # Ya tenemos para saber si es válido o no
    if valid_value == true
      respond_to do |format|
        if @promo.save
          format.html { redirect_to @promo, notice: 'La promoción se ha creado con éxito' }
          format.json { render :show, status: :created, location: @promo }
        else
          format.html { render :new, alert: @promo.errors }
          format.json { render json: @promo.errors, status: :unprocessable_entity }
        end
      end
    else
      flash.now[:error] = 'Debes seleccionar al menos una opción.'
      render('new') && return
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:error] = e
    redirect_to '/promos/new'
  end

  def verify_id!
    authenticate_user!
    unless @promo.user == current_user
      redirect_to root_path, alert: 'No eres el propietario de esta empresa y no puedes operarla.'
    end
  end

  # returns the date to wait to in plans plus and basic given the last promo
  def waiting_date(last_promo_item, plan)
    num = ((last_promo_item.validez - last_promo_item.created_at) / 60 / 60 / 24).round
    case num
    when 7
      if plan == 'plus'
        last_promo_item.validez + 3.days
      elsif plan == 'basic'
        last_promo_item.validez + 10.days
      end
    when 3
      if plan == 'plus'
        last_promo_item.validez + 2.days
      elsif plan == 'basic'
        last_promo_item.validez + 5.days
      end
    when 1
      if plan == 'plus'
        last_promo_item.validez + 1.days
      elsif plan == 'basic'
        last_promo_item.validez + 2.days
      end
    else
      # Error -> Promo lasted and unselectable number of days
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def promo_params
    params.require(:promo).permit(:titulo, :version, :imgpromo, :texto, :validez, :normal_price, :special_price)
  end
end
