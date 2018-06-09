class Superadmin::EventosController < Superadmin::ApplicationController
  before_action :set_evento, only: [:edit, :update, :destroy]
  def index
    @eventos = Evento.all.order(created_at: :desc)
  end
  def new
    @evento = Evento.new
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
  def edit

  end
  def update
    respond_to do |format|
      if @evento.update(evento_params)
        format.html { redirect_to superadmin_eventos_path, notice: 'El evento se ha actualizado con éxito' }
        format.json { render :show, status: :ok, location: @evento }
      else
        format.html { render :edit }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @evento.destroy
    respond_to do |format|
      format.html { redirect_to superadmin_promos_path, notice: 'Evento eliminado.' }
      format.json { head :no_content }
    end
  end
  private
  def set_evento
    @evento = Evento.find(params[:id])
  end
  def evento_params
    params.require(:evento).permit(:titulo, :imgevento, :info, :fecha)
  end
end
