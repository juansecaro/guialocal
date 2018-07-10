class EventosController < ApplicationController
  before_action :set_evento, only: [:show, :edit, :update, :destroy]
  before_action :authorize_editor!, only: [:editor_index, :new, :edit, :update, :destroy]

  # GET /eventos
  # GET /eventos.json
  def index
    @eventos = Evento.where("DATE(fecha) >= ?", Date.today).order(fecha: :asc).paginate(page: params[:page], per_page: 20)
  end

  # GET /eventos/1
  # GET /eventos/1.json
  def show
  end

  # GET /eventos/new
  def new
    @evento = Evento.new
  end

  # GET /eventos/1/edit
  def edit
  end

  def editor_index
    @eventos = Evento.order(created_at: :desc)
  end

  # POST /eventos
  # POST /eventos.json
  def create
    @evento = Evento.new(evento_params)

    respond_to do |format|
      if @evento.save
        format.html { redirect_to @evento, notice: 'El evento se ha creado con éxito' }
        format.json { render :show, status: :created, location: @evento }
      else
        format.html { render :new }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eventos/1
  # PATCH/PUT /eventos/1.json
  def update
    respond_to do |format|
      if @evento.update(evento_params)
        format.html { redirect_to @evento, notice: 'El evento se ha actualizado con éxito' }
        format.json { render :show, status: :ok, location: @evento }
      else
        format.html { render :edit }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventos/1
  # DELETE /eventos/1.json
  def destroy
    @evento.destroy
    respond_to do |format|
      format.html { redirect_to eventos_url, notice: 'El evento ha sido borrado' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evento
      @evento = Evento.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash.alert = "El evento que buscas no está aquí"
      redirect_to root_path
    end

    def authorize_editor!
      authenticate_user!
      unless (current_user.editor?)
        redirect_to root_path, alert: "Tú no eres editor."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evento_params
      params.require(:evento).permit(:info, :imgevento, :titulo, :fecha)
    end
end
