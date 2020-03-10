require 'open-uri'
require 'nokogiri'
require 'faker'

start = Time.now
puts "Time is #{start}, destroying seed and restarting seed..."
Investment.destroy_all
Reward.destroy_all
Campaign.destroy_all
Company.destroy_all
User.destroy_all

USERS = {
  owners: [
# { first_name: "admin" , last_name: "admin", email: "admin@gmail.com" , password: 12345678, admin: true},
{ first_name: "Ben" , last_name: "Deb", email: "ben@gmail.com" , password: 12345678},
{ first_name: "Thomas" , last_name: "Holder", email: "thomas@gmail.com" , password: 12345678 },
{ first_name: "Hank" , last_name: "Hng", email: "hank@gmail.com" , password: 12345678 },
{ first_name: "Joaco" , last_name: "Panelati", email: "joaco@gmail.com" , password: 12345678 },
{ first_name: "Morgan" , last_name: "Hare", email: "morgan@gmail.com" , password: 12345678 },
{ first_name: "Sebas" , last_name: "Sempe", email: "sebas@gmail.com" , password: 12345678 },
{ first_name: "Manuel" , last_name: "Scholz", email: "manuel@gmail.com" , password: 12345678 },
{ first_name: "Julius" , last_name: "Ahlert", email: "julius@gmail.com" , password: 12345678 },
{ first_name: "Analida" , last_name: "Corro", email: "analida@gmail.com" , password: 12345678 },
{ first_name: "Emilie" , last_name: "Drop", email: "emilie@gmail.com" , password: 12345678 },
],
investors: [
  { first_name: "Hernan" , last_name: "Kina", email: "investorhernan@gmail.com" , password: 12345678, link: "https://avatars1.githubusercontent.com/u/35240578?v=4"  },
  { first_name: "Jose" , last_name: "Ignacio", email: "investorjose@gmail.com" , password: 12345678, link: "https://avatars3.githubusercontent.com/u/40840106?v=4"  },
  { first_name: "Xenia" , last_name: "Boula", email: "investorxenia@gmail.com" , password: 12345678, link: "https://avatars2.githubusercontent.com/u/57909856?v=4"  },
  { first_name: "Nico" , last_name: "Donoso", email: "investornico@gmail.com" , password: 12345678, link: "https://avatars1.githubusercontent.com/u/35240578?v=4"  },
  { first_name: "Feli" , last_name: "Hernandez", email: "investorfeli@gmail.com" , password: 12345678, link: "https://avatars1.githubusercontent.com/u/35240578?v=4"  },
  { first_name: "James" , last_name: "Loomos", email: "investorjames@gmail.com" , password: 12345678, link: "https://avatars1.githubusercontent.com/u/35240578?v=4"  },
]}

# Reward amount
AMOUNT = %w(500 1000 2000 5000)

# Loan duration
DURATION = %w(12 24 36 48 60)

# #Edit
CAMPAIGNS = {
  title: [
    'A new restaurant concept is coming to Palermo Soho. Be part of the movement.',
    'Vegan pizza is taking over Buenos Aires! We need your support to open location #3.',
    'Great views, great cocktails, great people. Your new place to connect in Palermo Hollywood.',
    'From chacarita to CABA. Delicious burgers are a human right for all residents in BA!',
    'Puerto madero meets Itallian Coffee. Help us create the coolest coffee bar in Argentina.'
  ],
  description: [
    'The best of Italy in coming to downtown Buenos Aires. Maria and Fernando are running one of the most pistoresque pizzeria\'s in Rome. Bon Appétit!',

    'Six years and three successful restaurants later, we’re trying for another. Our chef José migrated from Cancun to Buenos Aires to guarantee all our wraps our made with a Latino flair!',

    'Culture is the weave that holds people in Argentina together. At the center of is Mate. We source our yerba leaves from local farmers only.',

    'Buenos Aires had to miss Peruvian ceviche for too long, but suffering is no longer needed! We get firsthand choice from our fish-suppliers and our cooks are ready to delight your tastebuds.',

    'Due to high demand, we\'re are looking for a new home with more seating capacity to host our empanada-loving customers. We need your support to make the dream come true.'
  ]
}

REWARDS = {
  description: [
    '10%/ Members discount for life!',
    'Free bottle of champange',
    'Have a cocktail named after you!',
    'Have a meal named after you!',
    'Have your name on the founders list!'
  ]
}

COMPANY = {
  address: [
    "Av Niceto Vega #{rand(100..4000)}, CABA, Buenos Aires",
    "Av. Córdoba #{rand(100..4000)},CABA, Buenos Aires",
    "Av. del Libertador #{rand(100..4000)}, C1425 CABA, Buenos Aires",
    "Av. Antártida Argentina #{rand(100..4000)}, CABA, Buenos Aires",
    "Marcelo Torcuato de Alvear #{rand(100..4000)}, CABA, Buenos Aires",
    "Av. Santa Fe #{rand(100..4000)}, CABA, Buenos Aires",
    "#{rand(100..4000)} Bartolomé Mitre, CABA, Buenos Aires",
    "Av. Federico Lacroze #{rand(100..4000)}, CABA, Buenos Aires",
    "Av. Luis María Campos #{rand(100..4000)}, CABA, Buenos Aires",
    "Acevedo #{rand(100..4000)}, CABA, Buenos Aires",
    "Murillo #{rand(100..4000)}, CABA, Buenos Aires",
    "Guardia Vieja #{rand(100..4000)}, CABA, Buenos Aires",
    "Paraguay #{rand(100..4000)}, CABA, Buenos Aires",
    "Guatemala #{rand(100..4000)}, CABA, Buenos Aires",
    "Malabia #{rand(100..4000)}, CABA, Buenos Aires",
    "Jorge Luis Borges #{rand(100..4000)}, CABA, Buenos Aires",
    "Thames #{rand(100..4000)}, CABA, Buenos Aires"
  ]
}

# named investors to log-in and log-out
USERS[:investors].each do |inv|
  investor = User.create!(first_name: inv[:first_name], last_name: inv[:last_name], owner: false, password: "12345678", email: inv[:email])
  photo = URI.open(inv[:link])
  investor.photo.attach(io: photo, filename: "new#{investor.first_name}.jpeg", content_type: 'image/png')
end

# random faker investors from the web
50.times do
  investor = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, owner: false, password: "12345678", email: Faker::Internet.email)
  # photo = URI.open(Faker::Avatar.image)
  # investor.photo.attach(io: photo, filename: "new#{investor.first_name}.jpeg", content_type: 'image/png')
  puts "#{investor.first_name} #{investor.last_name}"
end

def create_investment(campaign, reward, investor)
  investment = Investment.new
  investment.status = rand(0..4) #check enumerable in investment.rb (model)
  investment.amount = rand(1..10000)
  investment.payment_date = Date.today + rand(-30..1).days
  investment.campaign = campaign
  investment.reward = reward
  investment.investor = investor
  investment.save!
end

def create_reward(campaign)
  AMOUNT.each_with_index do |amount, index|
    reward = Reward.new()
    reward.description = "#{index + 1} x Free Dinner"
    reward.investment_amount = amount
    reward.campaign = campaign
    reward.save!
  end
end

def create_campaign(company)
  campaign = Campaign.new

  campaign.title = CAMPAIGNS[:title].sample
  campaign.description = CAMPAIGNS[:description].sample

  campaign.repayment_capacity = ("A".."C").to_a.sample
  campaign.financial_health = ("A".."C").to_a.sample
  campaign.company_history = ("A".."C").to_a.sample

  campaign.min_target = rand(20000..100000)
  campaign.max_target = campaign.min_target * (1+ rand(0.1..0.5))
  campaign.loan_duration = DURATION.sample
  campaign.return_rate = rand(0.05..0.1).round(1)
  campaign.expiry_date = Date.today + rand(-90..90).days

  campaign.company = company
# campaign.investor_id = rand(User.first.id..User.last.id)
campaign.save!
create_reward(campaign)

User.where(owner: false).each do |investor|
  create_investment(campaign, Reward.all.sample, investor)
  end
end

  # data scraper
  url = "https://www.eater.com/maps/best-buenos-aires-restaurants-38"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  type_store = %w(Restaurant Cafe Bar)

  html_doc.search('.c-mapstack__cards--mobile-map .c-mapstack__card').take(USERS[:owners].count).each_with_index do |element, count|
    names = element.search('h1').text.strip.gsub!(/\d+. /,"")
    description = element.search('.c-entry-content p').text.strip
  # create owner with company
  owner_info = USERS[:owners][count]
  owner = User.create!(owner_info)
  owner.update(owner: true)

  company = Company.new(
    name: names,
    address: COMPANY[:address].sample,
    type_store: type_store.sample,
    description: description,
    owner: owner
    )
  company.num_employees = rand(9..35)
  file = URI.open("https://source.unsplash.com/1600x900/?food")
  company.photo.attach(io: file, filename: "#{rand(1..999)}.jpeg", content_type: 'image/png')
  company.save!
  create_campaign(company)
end


puts "Seeds succesful"
puts "#{User.where(owner: false).count} investors created"
puts "#{User.where(owner: true).count} owners created"
puts "It took #{(Time.now - start) / 60}. minutes to seed."

