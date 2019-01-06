class PromosController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show ]
  before_action :control_max_promos, only: :create
  before_action :set_promo, only: :show
  #before_filter ->{ authenticate_user!( force: true ) }, only: [:index, :create, :mispromos]

  def new
    @promo = Promo.new
    @plan = current_user.empresa.plan
  end

  def create
    @promo = Promo.new(promo_params)
    @promo.empresa_id = current_user.empresa.id

    plan = current_user.empresa.plan
    #last_promo = current_user.empresa.try(:promos).try(:last).try(:created_at)
    #last_promo_when = helpers.time_format_mini(last_promo) if last_promo.nil? == false

    if (plan == 'noplan')
      flash[:error] = "No puedas lanzar promociones. Tu plan está fuera de validez. Renuévalo."
      redirect_to root_path
    else
      create_promo
    end

  end

  def edit

  end

  def update

  end

  def destroy

  end
  def mispromos
    plan = current_user.empresa.plan
    last_promo = current_user.empresa.try(:promos).try(:first)

    if plan != 'premium'
      if last_promo != nil
        waiting = waiting_date(last_promo, plan)
        if (waiting > Time.zone.now)
          @waiting = (waiting - Time.zone.now).to_i
        end
      else
        @waiting = nil
      end
    end

    @pasadas = Promo.where("validez <= ? AND empresa_id = ?", Time.zone.now, current_user.empresa.id).order("created_at DESC")
    @actuales = Promo.where("validez > ? AND empresa_id = ?", Time.zone.now, current_user.empresa.id).order("created_at DESC")

    @ready = false
    case plan
    when 'premium'
      if (@actuales.count < 3)
        return @ready = true
      else
        if is_still_valid?(@actuales[0]) == false
          return @ready = true # At least the last one isn' valid
        else
          @waiting = @actuales[0].validez.to_i - Time.zone.now.to_i
          flash.now[:notice] = "Has llegado al límite máximo (3) de promociones simultáneas"
        end
      end
    when 'plus'
      return @ready = true if @waiting == nil
    when 'basic'
      return @ready = true if @waiting == nil
    end

  end

  def index
    @promos = Promo.todas_diez_dias.paginate(page: params[:page], per_page: 20)
  end

  def show
    flash.now[:notice] = "Enséñale esto al comerciante para obtener tu descuento"
    @waiting = (@promo.validez - Time.zone.now).to_i

    titulo ||= "Oferta flash: " + @promo.titulo
    site ||= "Guia#{ENV['CURRENT_CITY_CAP']}.es"
    info ||= Nokogiri::HTML(@promo.texto).text.truncate(255, separator: ' ')

    set_meta_tags title: titulo,
                site: site,
                reverse: true,
                description: info,
                keywords: titulo,

                twitter: {
                  card: "summary",
                  site: site,
                  title: titulo + " | " + site,
                  description:  info,
                  image: @promo.imgpromo.url
                },

                og: {
                  title:    titulo + " | " + site,
                  description: info,
                  type:     'article',
                  url:      promo_url(@promo),
                  image:    @promo.imgpromo.url
                }


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promo
      @promo = Promo.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "La promoción que buscas no existe"
      redirect_to (request.referrer || root_path)
    end

    def control_max_promos
      #Delete the oldest when reach 20
      current_user.empresa.promos.order(created_at: :desc).last.destroy if current_user.empresa.promos.count > 19
    end


    def set_validez

      case params[:promo][:validezElegida]
      when 'alta'
        @promo.validez = Time.zone.now + 7.days
      when 'media'
        @promo.validez = Time.zone.now + 3.days
      when 'baja'
        @promo.validez = Time.zone.now + 1.day
      end

    end

    def is_still_valid?(promo)
      if promo.validez <= Time.zone.now
        false
      else
        true
      end
    end

    def create_promo
      #===========> Remember the promos are odered inversely so I take first (more recent one)
        valid_value = false
        last_promo = current_user.empresa.try(:promos).try(:first).try(:created_at)
        plan = current_user.empresa.plan
        #nil??? primera vez??
          if (Config.first.happyhour == true)
            if (last_promo + 1.hour < Time.now ) #nil?
              valid_value = true
              set_validez
            else
              flash.now[:error] = "Tiene que pasar al menos una hora entre promociones"
              render 'new' and return
            end
          else
            #no happy hour
            if last_promo == nil #no previous publication
              valid_value = true
              set_validez
            else
              if (plan == 'premium')
                last_promos = current_user.empresa.try(:promos).try(:first, 3)
                if last_promos.count < 3
                  valid_value = true
                  set_validez
                else
                  # It has 3 or more
                  if is_still_valid?(last_promos[2]) # last and oldest element
                    #All 3 options active, must wait until at least 1 finish validity
                    flash.now[:error] = "Tienes 3 promociones en activo (Máximo). Cuando acabe una podrás poner más."
                    render 'new' and return
                  else
                    # We know not all 3 options are active, so we can activate a new one
                    valid_value = true
                    set_validez
                  end
                end
              else
                #basic/plus
                last_promo_item = current_user.empresa.try(:promos).try(:first)
                if is_still_valid?(last_promo_item)
                  flash.now[:error] = "Tu última publicación aún está activa (pásate a premium si quieres varias y sin esperas)"
                  render 'new' and return
                else
                  #Has finished the waiting period?
                  @waiting_until = waiting_date(last_promo_item, plan)
                  if (Time.zone.now > @waiting_until)
                    valid_value = true
                    set_validez
                  else
                    flash.now[:error] = "Aún tienes que esperar hasta la próxima promoción (pásate a premium si no quieres esperas)"
                    render 'new' and return
                  end
                end

                end
              end
          end

    # Ya tenemos todo para saber si es válido o no
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
          flash.now[:error] = "Debes seleccionar al menos una opción."
          render 'new' and return
        end

        rescue ActiveRecord::RecordInvalid => e
          flash[:error] = e
          redirect_to '/promos/new'
          #===========> Final
    end

    def verify_id!
        authenticate_user!
        unless (@promo.user == current_user)
          redirect_to root_path, alert: "No eres el propietario de esta empresa y no puedes operarla."
        end
    end

    #returns the date to wait to in plans plus and basic given the last promo
    def waiting_date (last_promo_item, plan)
      num = ((last_promo_item.validez - last_promo_item.created_at)/60/60/24).round
      case num
      when 7
        if (plan == 'plus')
          last_promo_item.validez + 3.days
        elsif (plan == 'basic')
          last_promo_item.validez + 10.days
        end
      when 3
        if (plan == 'plus')
          last_promo_item.validez + 2.days
        elsif (plan == 'basic')
          last_promo_item.validez + 5.days
        end
      when 1
        if (plan == 'plus')
          last_promo_item.validez + 1.days
        elsif (plan == 'basic')
          last_promo_item.validez + 2.days
        end
      else
        #Error -> Promo lasted and unselectable number of days
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promo_params
      params.require(:promo).permit(:titulo, :imgpromo, :texto, :validez)
    end

end
