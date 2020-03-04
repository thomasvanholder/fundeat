class InvestmentsController < ApplicationController
  # attr_reader: investment

  def index
    @investments = policy_scope(Investment)
    authorize @investments
  end

  def show
    @investment = Investment.find(params[:id])
    authorize @investment
  end

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @investment = Investment.new(amount: params["investment"]["amount"])
    @reward = @campaign.rewards.first

    @investment.campaign = @campaign
    @investment.reward = @reward
    @investment.investor = current_user

    if @investment.valid?
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @campaign.title,
          # images: [campaign.photo_url],
          amount: @investment.amount * 100,
          currency: 'usd',
          quantity: 1
        }],
        success: investments_url
        # success_url: campaign_investment_url(@campaign, @investment),
        cancel_url: investments_url
        )
      @investment.save
      @investment.update(stripe_session_id: session.id)
    else
      render :new
    end
    authorize @campaign
    authorize @investment
  end

  def create
    @investment = Investment.new()
    authorize @investment

    @investment.reward_id = params[:investment][:reward].to_i
    @investment.amount = params["investment"]["amount"]
  end

  private

  # def investment_params
  #   params.require(:investment).permit(:amount, :reward)
  # end
end
