require 'open-uri'
require 'nokogiri'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

start = Time.now
puts "Time is #{start}, destroying seed and restarting seed..."
Investment.destroy_all
Reward.destroy_all
Campaign.destroy_all
Company.destroy_all
User.destroy_all

USERS = {
  owners: [
# <<<<<<< HEAD
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
  { first_name: "Janette" , last_name: "Kwan", email: "investorjanette@gmail.com" , password: 12345678, link: "https://avatars1.githubusercontent.com/u/35240578?v=4"  },
  { first_name: "Maximo" , last_name: "Chalbaud", email: "investormaximo@gmail.com" , password: 12345678, link: "https://avatars1.githubusercontent.com/u/35240578?v=4"  },
  { first_name: "Gerardo" , last_name: "Raiden", email: "investorgerardo@gmail.com" , password: 12345678, link: "https://avatars1.githubusercontent.com/u/35240578?v=4"  },
  { first_name: "Nicolas" , last_name: "Kennedy", email: "investornicolas@gmail.com" , password: 12345678, link: "https://media-exp1.licdn.com/dms/image/C4E03AQHAYB-Ut1y9oQ/profile-displayphoto-shrink_200_200/0?e=1586390400&v=beta&t=MRVdfv2LO7lnckrMzT9VAeZJWe4ScFker8NHNvD6U38"  },
]}

# Reward amount
AMOUNT = %w(500 1000 2000 5000)

# #Edit
CAMPAIGNS = {
  title: [
    'Expansion to Palermo, We will rock it!',
    'We want to open our third location in CABA. Are you in?',
    'Now ready to launch our Belgrano store. Be part of it!',
    'From chacarita to CABA. We are now opening our second location',
    'Puerto madero second location to be opened. Looking for supporters!'
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

# Edit
USERS[:investors].each do |inv|
  # puts inv[:first_name]
  investor = User.create!(first_name: inv[:first_name], last_name: inv[:last_name], owner: false, password: "12345678", email: inv[:email])
#  puts inv[:link]
#  puts inv[:email]
photo = URI.open(inv[:link])
# investor.photo.attach(io: photo, filename: "#{inv[:file]}", content_type: 'image/png')
investor.photo.attach(io: photo, filename: "new#{investor.first_name}.jpeg", content_type: 'image/png')
end

def create_investment(campaign, reward)
# puts "create investment"

investment = Investment.new
 investment.status = rand(0..4) #check enumerable in investment.rb (model)
 investment.amount = rand(1..10000)
 # investment.payment_date = campaign.expiry_date + (campaign.loan_duration * 30)
 investment.payment_date = rand(1..30).days.after

# caution. enhance code as each investor should not have more than one investment on the same company.
investment.investor = User.where(owner: false).sample
investment.campaign = campaign
investment.reward = reward
investment.save!
# puts "investment completed"
end

def create_reward(campaign)
  puts "create reward"
  AMOUNT.each_with_index do |amount, index|
    reward = Reward.new()
    reward.description = "#{index + 1} x Free Dinner"
    reward.investment_amount = amount
    reward.campaign = campaign
    reward.save!
    puts reward.id
    puts "completed create reward"
    create_investment(campaign, reward)
  end
end

def create_campaign(company)
  # puts "creating campaign"
  campaign = Campaign.new

  campaign.title = CAMPAIGNS[:title].sample

  campaign.repayment_capacity = rand(1..3)
  campaign.financial_health = rand(1..3)
  campaign.company_history = rand(1..3)
  campaign.risk_level = rand(1..3)

  campaign.min_target = rand(20000..60000)
  campaign.max_target = campaign.min_target + rand(20000..60000)
  campaign.loan_duration = rand(6..48)
  campaign.return_rate = rand(0.05..0.1).round(1)
  campaign.expiry_date = Date.today + rand(30..90).days

  campaign.company = company
# campaign.investor_id = rand(User.first.id..User.last.id)
campaign.save!
create_reward(campaign)
end

USERS[:owners].each do |owner_info|
  # puts "creating an owner"
  owner = User.create!(owner_info)
owner.update(owner: true)
# puts owner.first_name
end
url = "https://www.eater.com/maps/best-buenos-aires-restaurants-38"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
type_store = %w(Restaurant Cafe Bar)

html_doc.search('.c-mapstack__cards--mobile-map .c-mapstack__card').take(9).each do |element|
# puts element.text.strip
names = element.search('h1').text.strip.gsub!(/\d+. /,"")
address = element.search('.c-mapstack__address').text.strip
description = element.search('.c-entry-content p').text.strip

# create users with company
count = 1
company = Company.new(
  name: names,
  address: address,
  type_store: type_store.sample,
  description: description,
  instagram_url: "https://www.instagram.com/#{names}",
  tripadvisor_url: "https://www.tripadvisor.com/Search?q=#{names}&searchSessionId=1F6B12580414656E2B1F8103584658EB1583247846007ssid&sid=46FA130A0D7E735E3345681E166688851583247849993&blockRedirect=true",
  googlereview_url: "https://www.google.com/search?client=ubuntu&hs=hBX&channel=fs&ei=eHNeXpmBGf7Y5OUP-7Ww8Aw&q=#{names}#"
  )
company.num_employees = rand(9..35)
company.owner = User.where(owner: true)[count]
file = URI.open("https://source.unsplash.com/900x600/?#{company.type_store}")
company.photo.attach(io: file, filename: "#{rand(1..999)}.jpeg", content_type: 'image/png')

company.save
# puts company.name

# company.valid?
create_campaign(company)
count += 1
# =======

end

puts "Seeds succesful"
puts "It took #{(Time.now - start) / 60}. minutes to seed."

