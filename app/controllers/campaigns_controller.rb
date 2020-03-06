class CampaignsController < ApplicationController
 #Note! pundit was implemented. remember to authorize your variables with for example. authorize@campaign
 skip_before_action :authenticate_user!, only: [:index, :show, :raising]
 def index
  @campaigns = policy_scope(Campaign)
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

def raising
  @campaigns = policy_scope(Campaign)
  authorize @campaigns
end

def owners_dashboard
    @campaigns = Campaign.where(owner_id: current_user.id)
    authorize @campaigns
end

  # def dashboard
  #   if current.user.owner?
  #     :owner_dashboard
  #   else
  #     render :investor_dashboard
  #   end
  # end

  def support
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title)
  end

end
