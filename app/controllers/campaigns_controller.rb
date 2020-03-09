class CampaignsController < ApplicationController
  #Note! pundit was implemented. remember to authorize your variables with for example. authorize@campaign
  skip_before_action :authenticate_user!, only: [:index, :show, :raising]
  def index
    if params[:query].present?
      sql_query = " \
      companies.type_store ILIKE :query \
      "
      @campaigns = Campaign.joins(:company).where(sql_query, query: "%#{params[:query]}%")
    else
      @campaigns = policy_scope(Campaign)
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
    @investment = Investment.new
    authorize @campaign
    @company = @campaign.company

    if @company.type_store == "Bar"
      url = helpers.asset_url('bar.png')
    elsif @company.type_store == "Cafe"
      url = helpers.asset_url('cafe.png')
    else
      url = helpers.asset_url('restaurant.png')
    end

    @marker = [{
      lat: @company.latitude,
      lng: @company.longitude,
      image_url: url
    }]
  end

  def new
    @campaign = Campaign.new
    @company = Company.new
    authorize @campaign
    authorize @company
  end

  def create
    @company = Company.new
    authorize @company
    @company.owner = current_user
    @company.address = params[:company]["address"]
    @company.name = params[:company]["name"]
    @company.num_employees = params[:company]["num_of_employees"]
    @company.description = params[:company]["description"]

    @campaign = Campaign.new
    authorize @campaign
    @campaign.title = params[:campaign][:title]
    @campaign.description = params[:campaign][:description]
    @campaign.min_target = params[:campaign][:min_target]
    @campaign.description = params[:campaign][:description]
    @campaign.loan_duration = params[:campaign][:loan_duration]

    # seeded data
    @campaign.repayment_capacity = ("A".."C").to_a.sample
    @campaign.financial_health = ("A".."C").to_a.sample
    @campaign.company_history = ("A".."C").to_a.sample
    @campaign.return_rate = rand(0.05..0.1).round(1)
    @campaign.expiry_date = Date.today + rand(5..30).days
    @campaign.risk_level = total_risk_level

    @campaign.company = @company

    reward = Reward.new
    authorize = reward
    reward.investment_amount = params[:reward1][:investment_amount]
    reward.description = params[:reward1][:description]
    reward.campaign = @campaign
    reward.save

    reward = Reward.new
    authorize = reward
    reward.investment_amount = params[:reward2][:investment_amount]
    reward.description = params[:reward2][:description]
    reward.campaign = @campaign
    reward.save

    reward = Reward.new
    authorize = reward
    reward.investment_amount = params[:reward3][:investment_amount]
    reward.description = params[:reward3][:description]
    reward.campaign = @campaign
    reward.save

    reward = Reward.new
    authorize = reward
    reward.investment_amount = params[:reward4][:investment_amount]
    reward.description = params[:reward4][:description]
    reward.campaign = @campaign
    reward.save
      # raise
      if @campaign.save
        redirect_to mycampaigns_path, notice: 'Campaign was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
    end

    def raising
      @campaigns = policy_scope(Campaign)
      authorize @campaigns
    end

    def my_campaigns
      @campaigns = Campaign.where(owner_id: current_user.id)
      authorize @campaigns
    end


    def owners_dashboard
      @campaigns = Campaign.where(owner_id: current_user.id)
      authorize @campaigns
    end

    def mycampaigns
      @campaign = Campaign.new
      @company = Company.new
      authorize @campaign
      @campaigns = policy_scope(Campaign)
      authorize @campaigns
    end
    def total_risk_level
      char_array = []
      char_array << @campaign.repayment_capacity
      char_array << @campaign.financial_health
      char_array << @campaign.company_history
      string = char_array.join.gsub!(/[ABC]/, 'A' => 1, 'B' => 2, 'C' => 3)
      num_array = string.split(//)
      sum = 0
      num_array.each { |i| sum += i.to_i }
      average = (sum / 3).round(0).to_s
      @campaign.risk_level = average.gsub!(/[123]/, '1' => 'A', '2' => 'B', '3' => 'C')
    end

    def dashboard
      if current.user.owner?
        :owner_dashboard
      else
        render :investor_dashboard
      end
    end

    def support
      @campaigns = policy_scope(Campaign)
      authorize @campaigns
    end

    private

    def campaign_params
      params.require(:campaign).permit(:title)
    end

  end
