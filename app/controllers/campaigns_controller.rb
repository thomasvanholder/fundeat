class CampaignsController < ApplicationController
 #Note! pundit was implemented. remember to authorize your variables with for example. authorize@campaign
 skip_before_action :authenticate_user!, only: [:index, :show]
  def index
  @campaigns = policy_scope(Campaign)
  authorize @campaigns
  end

  def show
  @campaign = Campaign.find(params[:id])
  @investment = Investment.new
  authorize @campaign
  @company = @campaign.company


  @marker = [{
    lat: @company.latitude,
    lng: @company.longitude,
    # image_url: helpers.asset_url('restaurant.png')
  }]
  end

  def new
    @campaign = Campaign.new
    @company = Company.new
    authorize @campaign
    authorize @company
  end

  def create
  authorize @campaign
  end

  def edit
  end

  def update
  end

  def my_campaigns
  index
  end

  private

  def campaign_params
  params.require(:campaign).permit(:title)
  end

end
