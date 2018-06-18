class IncidentsController < ApplicationController

  # GET /incidents/1
  # GET /incidents/1.json
  def show
  end

  # GET /incidents/new
  def new
    @incident = Incident.new
  end

  # POST /incidents
  # POST /incidents.json
  def create
    @incident = Incident.new(incident_params)
    @incident.status = "abierto"
    @incident.user ||= current_user

    respond_to do |format|
      if @incident.save
        format.html { redirect_to @incident, notice: 'Incidencia registrada' }
        format.json { render :show, status: :created, location: @incident }
      else
        format.html { render :new }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
    end
  end



  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def incident_params
      params.require(:incident).permit(:info, :subject, :status, :user_id, comments_attributes: [:info])
    end
end
