class Admin::EmpresasController < Admin::ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update]

  # GET /empresas
  # GET /empresas.json
  def index
    @empresas = Empresa.all
  end

  # GET /empresas/1
  # GET /empresas/1.json
  def show
    (@hor, @abierto) = horario()
    @promos = @empresa.promos.last(3)
  end

  # GET /empresas/new
  def new
    @empresa = Empresa.new
  end

  # GET /empresas/1/edit
  def edit
  end

  # POST /empresas
  # POST /empresas.json
  def create
    @empresa = Empresa.new(empresa_params)

    respond_to do |format|
      if @empresa.save
        format.html { redirect_to @empresa, notice: 'Empresa creada con éxito.' }
        format.json { render :show, status: :created, location: @empresa }
      else
        format.html { render :new }
        format.json { render json: @empresa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /empresas/1
  # PATCH/PUT /empresas/1.json
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


  private
    # Use callbacks to share common setup or constraints between actions.
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

    def now_is_between?(time1,time2)

      t1 = Time.new(2000,1,1,time1[0,2].to_i,time1[3,2].to_i)
      t2 = Time.new(2000,1,1,time2[0,2].to_i,time2[3,2].to_i)


      return (t1.strftime( "%H%M" ) <= Time.now.strftime( "%H%M" )) && (Time.now.strftime( "%H%M" ) < t2.strftime( "%H%M" ))

    end

    def horario
      index = Time.now.wday
      @abierto = false

      case index
      when 1 #Lunes

        if (@empresa.schedule2.blank? || @empresa.schedule3.blank?)
          if (@empresa.schedule0.blank? || @empresa.schedule1.blank?)
            @salida = ""
          else
            @salida = "Hoy abre de #{@empresa.schedule0} a #{@empresa.schedule1}"
            @abierto = now_is_between?(@empresa.schedule0, @empresa.schedule1)
          end
        else
          if (!@empresa.schedule0.blank? && !@empresa.schedule1.blank?)
            @salida = "Hoy abre de #{@empresa.schedule0} a #{@empresa.schedule1} y de #{@empresa.schedule2} a #{@empresa.schedule3}"
            @abierto= (now_is_between?(@empresa.schedule0, @empresa.schedule1) || now_is_between?(@empresa.schedule2, @empresa.schedule3))
          else
            @salida = "Horario no definido correctamente"
          end
        end

        return @salida, @abierto

      when 2

        if (@empresa.schedule6.blank? || @empresa.schedule7.blank?)
          if (@empresa.schedule4.blank? || @empresa.schedule5.blank?)
            @salida = ""
          else
            @salida = "Hoy abre de #{@empresa.schedule4} a #{@empresa.schedule5}"
            @abierto = now_is_between?(@empresa.schedule4, @empresa.schedule5)
          end
        else
          if (!@empresa.schedule4.blank? && !@empresa.schedule5.blank?)
            @salida = "Hoy abre de #{@empresa.schedule4} a #{@empresa.schedule5} y de #{@empresa.schedule6} a #{@empresa.schedule7}"
            @abierto= (now_is_between?(@empresa.schedule4, @empresa.schedule5) || now_is_between?(@empresa.schedule6, @empresa.schedule7))
          else
            @salida = "Horario no definido correctamente"
          end
        end

        return @salida, @abierto

      when 3

        if (@empresa.schedule10.blank? || @empresa.schedule11.blank?)
          if (@empresa.schedule8.blank? || @empresa.schedule9.blank?)
            @salida = ""
          else
            @salida = "Hoy abre de #{@empresa.schedule8} a #{@empresa.schedule9}"
            @abierto = now_is_between?(@empresa.schedule8, @empresa.schedule9)
          end
        else
          if (!@empresa.schedule8.blank? && !@empresa.schedule9.blank?)
            @salida = "Hoy abre de #{@empresa.schedule8} a #{@empresa.schedule9} y de #{@empresa.schedule10} a #{@empresa.schedule11}"
            @abierto= (now_is_between?(@empresa.schedule8, @empresa.schedule9) || now_is_between?(@empresa.schedule10, @empresa.schedule11))
          else
            @salida = "Horario no definido correctamente"
          end
        end

        return @salida, @abierto

      when 4

        if (@empresa.schedule14.blank? || @empresa.schedule15.blank?)
          if (@empresa.schedule12.blank? || @empresa.schedule13.blank?)
            @salida = ""
          else
            @salida = "Hoy abre de #{@empresa.schedule12} a #{@empresa.schedule13}"
            @abierto = now_is_between?(@empresa.schedule12, @empresa.schedule13)
          end
        else
          if (!@empresa.schedule12.blank? && !@empresa.schedule13.blank?)
            @salida = "Hoy abre de #{@empresa.schedule12} a #{@empresa.schedule13} y de #{@empresa.schedule14} a #{@empresa.schedule15}"
            @abierto= (now_is_between?(@empresa.schedule12, @empresa.schedule13) || now_is_between?(@empresa.schedule14, @empresa.schedule15))
          else
            @salida = "Horario no definido correctamente"
          end
        end

        return @salida, @abierto

      when 5

        if (@empresa.schedule18.blank? || @empresa.schedule19.blank?)
          if (@empresa.schedule16.blank? || @empresa.schedule17.blank?)
            @salida = ""
          else
            @salida = "Hoy abre de #{@empresa.schedule16} a #{@empresa.schedule17}"
            @abierto = now_is_between?(@empresa.schedule16, @empresa.schedule17)
          end
        else
          if (!@empresa.schedule16.blank? && !@empresa.schedule17.blank?)
            @salida = "Hoy abre de #{@empresa.schedule16} a #{@empresa.schedule17} y de #{@empresa.schedule18} a #{@empresa.schedule19}"
            @abierto= (now_is_between?(@empresa.schedule16, @empresa.schedule17) || now_is_between?(@empresa.schedule18, @empresa.schedule19))
          else
            @salida = "Horario no definido correctamente"
          end
        end

        return @salida, @abierto

      when 6

        if (@empresa.schedule22.blank? || @empresa.schedule23.blank?)
          if (@empresa.schedule20.blank? || @empresa.schedule21.blank?)
            @salida = ""
          else
            @salida = "Hoy abre de #{@empresa.schedule20} a #{@empresa.schedule21}"
            @abierto = now_is_between?(@empresa.schedule20, @empresa.schedule21)

          end
        else
          if (!@empresa.schedule20.blank? && !@empresa.schedule21.blank?)
            @salida = "Hoy abre de #{@empresa.schedule20} a #{@empresa.schedule21} y de #{@empresa.schedule22} a #{@empresa.schedule23}"
            @abierto= (now_is_between?(@empresa.schedule20, @empresa.schedule21) || now_is_between?(@empresa.schedule22, @empresa.schedule23))
          else
            @salida = "Horario no definido correctamente"
          end
        end

        return @salida, @abierto

      when 0

        if (@empresa.schedule26.blank? || @empresa.schedule27.blank?)
          if (@empresa.schedule24.blank? || @empresa.schedule25.blank?)
            @salida = ""
          else
            @salida = "Hoy abre de #{@empresa.schedule24} a #{@empresa.schedule25}"
            @abierto = now_is_between?(@empresa.schedule24, @empresa.schedule25)
          end
        else
          if (!@empresa.schedule24.blank? && !@empresa.schedule25.blank?)
            @salida = "Hoy abre de #{@empresa.schedule24} a #{@empresa.schedule25} y de #{@empresa.schedule26} a #{@empresa.schedule27}"
            @abierto= (now_is_between?(@empresa.schedule24, @empresa.schedule25) || now_is_between?(@empresa.schedule26, @empresa.schedule27))
          else
            @salida = "Horario no definido correctamente"
          end
        end

        return @salida, @abierto

      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_params
      params.require(:empresa).permit(:logo, :name, :tag_list ,:category_id, :description, :mlon, :mlat, :address, :web, :email, :tel, :video, {fotos:[]}, :schedule0, :schedule1, :schedule2, :schedule3, :schedule4, :schedule5, :schedule6,
         :schedule7, :schedule8, :schedule9, :schedule10, :schedule11, :schedule12, :schedule13, :schedule14, :schedule15, :schedule16, :schedule17, :schedule18, :schedule19, :schedule20, :schedule21, :schedule22, :schedule23, :schedule24, :schedule25, :schedule26, :schedule27, :remove_logo)
    end
end
