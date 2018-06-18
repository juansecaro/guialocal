class Superadmin::IncidentsController < Superadmin::ApplicationController
  before_action :set_incident, only: [:show, :edit, :update, :destroy]
  def index
    @incidents = Incident.all
  end

  def show
    user ||= current_user
    @incident.comments.build(user: user)
  end

  def new
    @incident = Incident.new
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.status = "abierto"
    @incident.user ||= current_user

    respond_to do |format|
      if @incident.save
        format.html { redirect_to root_path, notice: 'Gracias. Nos pondremos en contacto contigo muy pronto' }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    if params[:incident][:comments_attributes]["0"][:info] == ""
      redirect_to superadmin_incident_path(@incident), alert: 'Necesitas añadir información antes de actualizar el estado'
    else
      if params[:commit]=="Concluida"
        @incident.concluida!
      elsif params[:commit]=="Reportar"
        @incident.reportar!
      elsif params[:commit]=="Pendiente"
        @incident.pendiente!
      end
      respond_to do |format|
        if @incident.update(incident_params)
          @incident.touch
          format.html { redirect_to superadmin_incident_path(@incident), notice: 'Incidencia actualizada actualizada con éxito.' }
          format.json { render :show, status: :ok, location: @incident }
        else
          format.html { render :edit }
          format.json { render json: @incident.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @incident.destroy
    respond_to do |format|
      format.html { redirect_to superadmin_incidents_path, notice: 'Incidencia eliminada.' }
      format.json { head :no_content }
    end
  end

  private
  def set_incident
    @incident = Incident.find(params[:id])
  end

  def incident_params
    params.require(:incident).permit(:info, :subject, :status, :user_id, comments_attributes: [:id, :info, :_destroy])
  end

end
