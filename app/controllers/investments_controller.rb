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
    @investment = Investment.new(amount: params["investment"]["amount"], reward_id: params["investment"]["reward"].to_i)
    @investment.campaign = @campaign
    @session = params[:stripe_session_id]
    authorize @campaign
    authorize @investment
  end

  def create
    @investment = Investment.new()
    authorize @investment
    @investment.reward_id = params[:investment][:reward].to_i
    @investment.amount = params["investment"]["amount"]
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
      redirect_to investment_path(@investment)
    else
      raise
      render :new
    end
end

private

  # def investment_params
  #   params.require(:investment).permit(:amount, :reward)
  # end
end
