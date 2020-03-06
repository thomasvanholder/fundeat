
class InvestmentsController < ApplicationController
  # attr_reader: investment

  def index
    @investments = policy_scope(Investment)
    authorize @investments
  end



  def dashboard
    @investments = Investment.where(investor_id: current_user.id)
    authorize @investments

    sum = 0
    count = 0
    amount_by_proj = []
    labels_proj = []
    labels_months_of_invest = []

    @investments.where.not(payment_date: nil).each do |inv|
      sum += inv.campaign.return_rate
      count += 1
      amount_by_proj << inv.amount
      labels_proj << inv.campaign.company.name
      labels_months_of_invest << (inv.payment_date)&.strftime("%m/%d/%Y")

    end

    @avge_int_rate = sum/count
    @graph_data_pie = {
              # labels: ['Jan', 'Feb', 'March', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep','Oct', 'Nov', 'Dec'],
              labels: labels_proj,
              datasets: [{
                label: 'Investment / Month',
                  # data: [12, 19, 3, 5, 2, 3, 5, 6, 12, 3, 23, 12],
                  data: amount_by_proj,
                  backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
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
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                  ],
                  borderWidth: 1
                }]
              }

              @graph_data_bar = {
      # labels: ['Jan', 'Feb', 'March', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep','Oct', 'Nov', 'Dec'],
      labels: labels_months_of_invest,
      datasets: [{
        label: 'Investment / Month',
          # data: [12, 19, 3, 5, 2, 3, 5, 6, 12, 3, 23, 12],
          data: amount_by_proj,
          backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(255, 206, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)',
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
            'rgba(255, 206, 86, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(153, 102, 255, 1)',
          ],
          borderWidth: 1
        }]
      }
    end

    def myinvestments
      @investments = Investment.where(investor_id: current_user.id)
      authorize @investments
    end

    def rewards
      @investments = Investment.where(investor_id: current_user.id)
      authorize @investments
      # @rewards = Investment.where(investor_id: current_user.id).rewards
      # authorize @rewards
    end
    def map
      @investments = Investment.where(investor_id: current_user.id)
      authorize @investments
    end
    def show
      @investment = Investment.find(params[:id])
      authorize @investment
    end

    def new
      @campaign = Campaign.find(params[:campaign_id])
      authorize @campaign
      @investment = Investment.new(amount: params["investment"]["amount"])
      authorize @investment

      @reward = @campaign.rewards.first

      @investment.campaign = @campaign
      @investment.reward = @reward
      @investment.investor = current_user


    if @investment.valid?
      @investment.save
      investment_link = investment_url(@investment)
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @campaign.title,
          # images: @campaign.photo_url],

          amount: @investment.amount * 100,
          currency: 'usd',
          quantity: 1
        }],
        # success_url: investments_url,
        success_url: investment_link,
        cancel_url: campaigns_url
        )

      @investment.update(stripe_session_id: session.id)
    else
      render :new

    end
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
