class Admin::IncidentsController < ApplicationController
  before_action :set_incident, only: [:show, :edit, :update]
  def index
    @incidents = Incident.all
  end
  def show
    @incident.comments.build
  end

  def edit

  end

  def update
    respond_to do |format|
      if @incident.update(incident_params)
        format.html { redirect_to @incident, notice: 'Incidencia actualizada actualizada con éxito.' }
        format.json { render :show, status: :ok, location: @incident }
      else
        format.html { render :edit }
        format.json { render json: @incident.errors, status: :unprocessable_entity }
      end
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
