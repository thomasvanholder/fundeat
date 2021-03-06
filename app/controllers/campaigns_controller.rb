class CampaignsController < ApplicationController
#Note! pundit was implemented. remember to authorize your variables with for example. authorize@campaign
skip_before_action :authenticate_user!, only: [:index, :show, :raising]
before_action :owner_sidebar_menu

def index
  if params[:query].present?
    sql_query = " \
    companies.type_store ILIKE :query \
    "
    @campaigns = policy_scope(Campaign.joins(:company).where(sql_query, query: "%#{params[:query]}%"))
  else
    @campaigns = policy_scope(Campaign)
  end
  if params[:order] == "amount_low"
    @campaigns = @campaigns.order(:min_target)
  elsif
    params[:order] == "amount_high"
    @campaigns = @campaigns.order(min_target: :desc)
  elsif
    params[:order] == "date"
    @campaigns = @campaigns.order(:expiry_date)
  # raised sorting not yet completed
  # elsif
  #   params[:order] == "raised"
  #   @campaigns = @campaigns.order(:raised)
  else
    params[:order] == "interest"
    @campaigns = @campaigns.order(return_rate: :desc)
  end
end

def show
  @campaign = Campaign.find(params[:id])
  @investment = Investment.new
  authorize @campaign
  @company = @campaign.company
  #Note HK - Risklevel: this way risk level is shown in the show page. U comment "campaign.rb" as well. (i am just commenting it as Julius will be trying to fix it directly on the database.)
    # @campaign.risk_level = @campaign.total_risk_level

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
  create_company
  create_campaign
  create_rewards
# raise
  if @campaign.save
    redirect_to campaign_path(@campaign), notice: 'Campaign was successfully created.'
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

def mycampaigns
  @campaigns = current_user.campaigns
  authorize @campaigns

  if @campaigns.nil?
    redirect_to new_campaign_path
  end
end

def owner_sidebar_menu
  @menu =[
    {
      title: "Dashboard",
      action_name: "owners_dashboard",
      url: "/mycampaigns/owners_dashboard",
      class: ""
      },
      {
        title: "Investors",
        action_name: "investors",
        url: "/mycampaigns/investors",
        class: ""
        },
        {
          title: "Support",
          action_name: "support",
          url: "/mycampaigns/support",
          class: ""
          }]
        end

        def owners_dashboard
          if current_user.company.nil?
            redirect_to mycampaigns_path, notice: 'Nothing to show, create  your first campaign!'
            @campaign = policy_scope(Campaign)
            authorize @campaign
# render :mycampaigns
else
  @campaign = policy_scope(Campaign)
  authorize @campaign

  @company = current_user.company
  authorize @company
  @investments = @company.investments

  sum = 0
  count = 0
  amount_by_proj = []
  labels_proj = []
  labels_months_of_invest = []

  @investments.where.not(payment_date: nil).each do |inv|
    sum += inv.campaign.return_rate
    count += 1
    amount_by_proj << inv.amount
    labels_proj << inv.investor.first_name

    labels_months_of_invest << (inv.payment_date)&.strftime("%m/%d/%Y")
  end
end

if @avge_int_rate.nil?
  @graph_data_pie = {
# labels: ['Jan', 'Feb', 'March', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep','Oct', 'Nov', 'Dec'],
labels: labels_proj,
datasets: [{
  label: 'Investment over time',
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
  label: 'Investment over time',
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


else
  @avge_int_rate = sum/count

  @graph_data_pie = {
# labels: ['Jan', 'Feb', 'March', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep','Oct', 'Nov', 'Dec'],
labels: labels_proj,
datasets: [{
  label: 'Investment over time',
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
  label: 'Investment over time',
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

# i.count { |inv| inv.reward.description == "1 x Free Dinner" }

rewards_data = []
rewards_labels = []

@company.campaign.rewards.each do |reward|
  rewards_data << @investments.where.not(payment_date: nil).count do |inv|
    inv.reward == reward
  end
  rewards_labels << reward.description
end

if @avge_int_rate.nil?
  @graph_data_pie = {
# labels: ['Jan', 'Feb', 'March', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep','Oct', 'Nov', 'Dec'],
labels: rewards_labels,
datasets: [{
  label: 'Investment over time',
# data: [12, 19, 3, 5, 2, 3, 5, 6, 12, 3, 23, 12],
data: rewards_data,
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
  label: 'Investment over time',
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

else
  @avge_int_rate = sum/count

  @graph_data_pie = {
# labels: ['Jan', 'Feb', 'March', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep','Oct', 'Nov', 'Dec'],
labels: rewards_labels,
datasets: [{
  label: 'Investment over time',
# data: [12, 19, 3, 5, 2, 3, 5, 6, 12, 3, 23, 12],
data: rewards_data,
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
  label: 'Investment over time',
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

  average = (sum / 3.to_f).round(0).to_s
  return average.gsub!(/[123]/, '1' => 'A', '2' => 'B', '3' => 'C')
end

def dashboard
  if current.user.owner?
    :owner_dashboard
  else
    render :investor_dashboard
  end
end

def support
  @campaign = policy_scope(Campaign)
  authorize @campaign
end

def investors
  @campaign = current_user.company.campaign
  authorize @campaign
end

def create_company
  @company = Company.new
  authorize @company
  @company.owner = current_user
  @company.address = params[:company]["address"]
  @company.name = params[:company]["name"]
  @company.num_employees = params[:company]["num_of_employees"]
  @company.description = params[:company]["description"]
end


def create_campaign
  @campaign = Campaign.new
  authorize @campaign
  @campaign.title = params[:campaign][:title]
  @campaign.description = params[:campaign][:description]
  @campaign.min_target = params[:campaign][:min_target]
  @campaign.description = params[:campaign][:description]
  @campaign.loan_duration = params[:campaign][:loan_duration]
  @campaign.company = @company
  seed_campaign_data
  @campaign.risk_level = total_risk_level
end

def create_rewards
  (1..4).each do |reward_number| #################
    next if (params["reward#{reward_number}".to_sym][:investment_amount]).blank?
    reward = Reward.new
    authorize = reward
    reward.investment_amount = params["reward#{reward_number}".to_sym][:investment_amount]
    reward.description = params["reward#{reward_number}".to_sym][:description]
    reward.campaign = @campaign
    reward.save
  end
end

def seed_campaign_data
  @campaign.repayment_capacity = ("A".."C").to_a.sample
  @campaign.financial_health = ("A".."C").to_a.sample
  @campaign.company_history = ("A".."C").to_a.sample
  @campaign.return_rate = rand(0.05..0.1).round(1)
  @campaign.expiry_date = Date.today + rand(5..30).days
end

private

def campaign_params
  params.require(:campaign).permit(:title)
end

end
