class AchievementProposalsController < ApplicationController
  before_action :authenticate_user!
  def show
    @proposal = AchievementProposal.find(params[:id])
  end
end
