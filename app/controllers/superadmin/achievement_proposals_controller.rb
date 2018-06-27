class Superadmin::AchievementProposalsController < Superadmin::ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  def index
    @proposals = AchievementProposal.all
  end

  def new
    @proposal = AchievementProposal.new
  end

  def create
    @proposal = AchievementProposal.new(proposal_params)
    respond_to do |format|
      if @proposal.save
        format.html { redirect_to superadmin_achievement_proposals_path, notice: 'Propuesta de reto creada con éxito.' }
        format.json { render :index, status: :created, location: @proposal }
      else
        format.html { render :new }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

  end

  def edit
  end

  def update
    if @proposal.update(proposal_params)
      flash[:notice] = "Propuesta de reto editada con éxito."
      redirect_to superadmin_achievement_proposals_path
    else
      flash.now[:alert] = "Hubo un problema. No se pudo actualizar la propuesta de reto."
      render 'edit'
    end
  end

  def destroy
    @proposal.destroy
    flash[:alert] = "Se ha borrado la propuesta de reto."
    redirect_to superadmin_achievement_proposals_path
  end

  private
  def proposal_params
    params.require(:achievement_proposal).permit(:title, :info, :reward)
  end
  def set_proposal
    @proposal = AchievementProposal.find(params[:id])
  end



end
