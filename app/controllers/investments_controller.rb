class InvestmentsController < ApplicationController
  # attr_reader: investment

  def index
    @investments = policy_scope(Investment)
    authorize @investments
  end

  def dashboard
    @investments = policy_scope(Investment)
    authorize @investments

@graph_data = {
          labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange', 'Green', 'Purple', 'Orange'],
          datasets: [{
              label: '# of Votes',
              data: [12, 19, 3, 5, 2, 3, 5, 6, 123],
              backgroundColor: [
                  'rgba(255, 99, 132, 0.2)',
                  'rgba(54, 162, 235, 0.2)',
                  'rgba(255, 206, 86, 0.2)',
                  'rgba(75, 192, 192, 0.2)',
                  'rgba(153, 102, 255, 0.2)',
                  'rgba(255, 159, 64, 0.2)',
                  'rgba(75, 192, 192, 0.2)',
                  'rgba(153, 102, 255, 0.2)',
                  'rgba(255, 159, 64, 0.2)'
              ],
              borderColor: [
                  'rgba(255, 99, 132, 1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)',
                  'rgba(153, 102, 255, 1)',
                  'rgba(255, 159, 64, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)',
                  'rgba(153, 102, 255, 1)',
              ],
              borderWidth: 1
          }]
      }



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
        success_url: investments_url,
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
