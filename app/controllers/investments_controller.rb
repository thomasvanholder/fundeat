class InvestmentsController < ApplicationController
  def index
    @investments = policy_scope(Investment)
    authorize @investments
  end

  def show
  end

  def new
    # @campaign = Campaign.find(params[:capaign_id])
    # @investment = Investment.new
  end

  def create
    @investment = Investment.new(investment_params)
    authorize @investment
    @campaign = Campaign.find(params[:campaign_id])
    @investment.campaign = @campaign
    @investment.investor = current_user
    if @investment.valid?
      @investment.save
      redirect_to campaign_investments_path(@investment)
    else
      render :new
    end
  end

  private

  def investment_params
    params.require(:investment).permit(:amount)
  end
end
