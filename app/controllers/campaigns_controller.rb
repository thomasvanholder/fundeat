class CampaignsController < ApplicationController
 #Note! pundit was implemented. remember to authorize your variables with for example. authorize@campaign
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @campaings = policy_scope(Campaign)
    authorize @campaings
  end

  def show
    @campaign = Campaign.find(params[:id])
    authorize @campaign
  end

  def new
  end

  def create
    authorize @campaign
  end

  def edit
  end

  def update
  end

end
