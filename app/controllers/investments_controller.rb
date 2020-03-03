class InvestmentsController < ApplicationController
  def index
    @investments = policy_scope(Investment)
    authorize @investments
  end

  def show
  end

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @investment = Investment.new(amount: params["investment"]["amount"], reward_id: params["investment"]["reward"].to_i)
    @investment.campaign = @campaign
    authorize @campaign
    authorize @investment
  end

  def create
    @investment = Investment.new()
    authorize @investment
    @investment.reward_id = params[:investment][:reward].to_i
    @investment.amount = params[:investment][:amount]
    @campaign = Campaign.find(params[:campaign_id])
    @investment.campaign = @campaign
    @investment.investor = current_user
    @investment.save!

    if @investment.valid?
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @campaign.title,
          # images: [campaign.photo_url],
          amount: @investment.amount,
          currency: 'usd',
          quantity: 1
        }],
        success_url: investment_url(@investment),
        cancel_url: investment_url(@investment)
        )
      @investment.update(stripe_session_id: session.id)
      @investment.save!
      redirect_to new_campaign_investment_path(@campaign, invest: @investment)
    else
      render :new
    end
end

private

  # def investment_params
  #   params.require(:investment).permit(:amount, :reward)
  # end
end
