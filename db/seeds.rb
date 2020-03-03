# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "destroy all seeds"
Investment.destroy_all
Reward.destroy_all
Campaign.destroy_all
Company.destroy_all
User.destroy_all

# Edit

COMPANY = {
  name: %w(Tipo7 Bellagamba Mirutake Tortoni Starbucks DelToro Delicatessen Pokeking Burgermeister Surry),
  type_store: %w(Restaurant Coffee_Store Bar),
  address: [
    "Av Niceto Vega #{rand(1..1000)}, CABA, Buenos Aires",
    "Av. Córdoba #{rand(1..1000)},CABA, Buenos Aires",
    "Av. del Libertador #{rand(1..1000)}, C1425 CABA, Buenos Aires",
    "Av. Antártida Argentina #{rand(1..1000)}, CABA, Buenos Aires",
    "Marcelo Torcuato de Alvear #{rand(1..1000)}, CABA, Buenos Aires",
    "Av. Santa Fe #{rand(1..1000)}, CABA, Buenos Aires",
    "#{rand(1..1000)} Bartolomé Mitre, CABA, Buenos Aires",
    "Av. Federico Lacroze #{rand(1..1000)}, CABA, Buenos Aires",
    "Av. Luis María Campos #{rand(1..1000)}, CABA, Buenos Aires",
    "Acevedo #{rand(1..1000)}, CABA, Buenos Aires",
    "Murillo #{rand(1..1000)}, CABA, Buenos Aires",
    "Guardia Vieja #{rand(1..1000)}, CABA, Buenos Aires",
    "Paraguay #{rand(1..1000)}, CABA, Buenos Aires",
    "Guatemala #{rand(1..1000)}, CABA, Buenos Aires",
    "Malabia #{rand(1..1000)}, CABA, Buenos Aires",
    "Jorge Luis Borges #{rand(1..1000)}, CABA, Buenos Aires",
    "Thames #{rand(1..1000)}, CABA, Buenos Aires"],
    # num_employees: %w(Restaurant CoffeeStore Bar),
    instagram_url: %w(url1 url2 url3 url4),
    tripadvisor_url: %w(url1 url2 url3 url4),
    googlereview_url: %w(url1 url2 url3 url4)
}

# MODEL = {
#   Yamaha: %w(GT100 IT125 LS2 100 MG1T MX125 RX50 RD200),
#   BMW: %w(K1200GT K1300R R75 R90S R100 R1100GS F650CS F800GT G310R G650GS),
#   Kawasaki: %w(Z250SL Z250 Z750 Z800 Z1000 ZRX1200R ZZR250 ZZR400 ZZR600 ZZR1100),
#   Honda: %w(CN250 Elite Express Joker Juno Motocompo Reflex PCX125 Ruckus SFX50),
#   Suzuki: %w(DR125 DR200SE DR350 DR650 FM50 FR50 FR80 FX125 FXR150 FZ50),
#   KTM: %w(50SXMini 65SX 390series 450EXC 450Rally 500EXC ),
#   Ducati: %w(65TL 65TS 98 125T 125TV 400SS 748 749 750GT 750 800SS),
#   Aprilia: %w(RS4125 RS50 RS125 RS250 RSV250 RST1000),
#   Triumph: %w(80 100 T110 800 955i 1050 Cub Daytona Explore Trail),
# }

# LICENSE_TYPE = %w(A1 A2 A3)
AMOUNT = %w(500 1000 5000 10000)

#OK

USERS = {
  owners: [
    # { first_name: "admin" , last_name: "admin", email: "admin@gmail.com" , password: 12345678, admin: true},
    { user_type: "owner", first_name: "Hernan" , last_name: "Kina", email: "hernan@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Thomas" , last_name: "Holder", email: "thomas@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Hank" , last_name: "Hng", email: "hank@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Joaco" , last_name: "Panelati", email: "joaco@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Morgan" , last_name: "Hare", email: "morgan@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Sebas" , last_name: "Sempe", email: "sebas@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Manuel" , last_name: "Scholz", email: "manuel@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Julius" , last_name: "Ahlert", email: "julius@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Analida" , last_name: "Corro", email: "analida@gmail.com" , password: 12345678 },
    { user_type: "owner", first_name: "Emilie" , last_name: "Drop", email: "emilie@gmail.com" , password: 12345678 },
  ],
  investors: [
    { user_type: "investor", first_name: "Ben" , last_name: "Deb", email: "ben@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "Jose" , last_name: "Ignacio", email: "jose@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "Xenia" , last_name: "Boula", email: "xenia@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "Nico" , last_name: "Donoso", email: "nico@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "Feli" , last_name: "Hernandez", email: "feli@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "James" , last_name: "Loomos", email: "james@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "Janette" , last_name: "Kwan", email: "janette@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "Maximo" , last_name: "Chalbaud", email: "maximo@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "Gerardo" , last_name: "Raiden", email: "gerardo@gmail.com" , password: 12345678 },
    { user_type: "investor", first_name: "Nicolas" , last_name: "Kennedy", email: "nicolas@gmail.com" , password: 12345678 },

  ]
}

#Edit

CAMPAIGNS = {
  title: [
    'Expansion to Palermo, We will rock it!',
    'We want to open our third location in CABA. Are you in?',
    'Now ready to launch our Belgrano store. Be part of it!',
    'From chacarita to CABA. We are now opening our second location',
    'Puerto madero second location to be opened. Looking for supporters!'
  ]
}

USERS[:investors].each do |investor|
  investor = User.create!(investor)
  # investor.photo.attach()
end

# Manually seed investor with photos

#1
  photo = URI.open("https://avatars1.githubusercontent.com/u/35240578?v=4")
  investor1 = User.create!(first_name: "Hernan" , last_name: "Kina", email: "newhernan@gmail.com" , password: 12345678 )
  investor1.photo.attach(io: photo, filename: "newhernan.jpeg", content_type: 'image/jpeg')

#2
  photo2 = URI.open("https://avatars0.githubusercontent.com/u/36309895?v=4")
  investor2 = User.create!(first_name: "Thomas" , last_name: "Holder", email: "newthomas@gmail.com" , password: 12345678 )
  investor2.photo.attach(io: photo2, filename: "newthomas.jpeg", content_type: 'image/jpeg')

#3
  photo3 = URI.open("https://avatars2.githubusercontent.com/u/30577676?v=4")
  investor3 = User.create!(first_name: "Hank" , last_name: "Hng", email: "newhank@gmail.com" , password: 12345678 )
  investor3.photo.attach(io: photo3, filename: "newhank.jpeg", content_type: 'image/jpeg')

#4
  # photo4 = URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1578932457/vw1y2j5jidn3chpxxbrx.jpg")
  # investor4 = User.create!(first_name: "Julius" , last_name: "Ahlert", email: "newjulius@gmail.com" , password: 12345678 )
  # investor4.photo.attach(io: photo, filename: "newjulies.jpeg", content_type: 'image/jpeg')


USERS[:owners].each do |owner_info|
  owner = User.create!(owner_info)


  1.times do
    company = Company.new()
    company.name = COMPANY[:name].sample
    company.type_store = COMPANY[:type_store].sample
    # company.type = Company::TYPE.sample
    company.address = COMPANY[:address].sample
    company.num_employees = rand(9..35)
    company.instagram_url = COMPANY[:instagram_url].sample
    company.tripadvisor_url = COMPANY[:tripadvisor_url].sample
    company.googlereview_url = COMPANY[:googlereview_url].sample
    company.description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio vel, libero. Qui ducimus explicabo vitae mollitia, illum harum maxime, magni beatae ipsam, nam nobis nisi. Debitis perferendis officiis ab quos."
    company.owner = owner
    file = URI.open("https://source.unsplash.com/900x600/?restaurant")
    company.photo.attach(io: file, filename: "#{rand(1..999)}.jpeg", content_type: 'image/png')
    company.save!



    1.times do
      campaign = Campaign.new()
      campaign.title = CAMPAIGNS[:title].sample
      campaign.description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magnam nemo aspernatur illo, ut sit harum, architecto laudantium ipsam repellendus iure dolorem, vero, at cumque sint facere! Adipisci, rem sit deserunt."
      campaign.repayment_capacity = rand(1..3)
      campaign.financial_health = rand(1..3)
      campaign.company_history = rand(1..3)
      campaign.risk_level = rand(1..3)

      campaign.min_target = rand(20000..60000)
      campaign.max_target = campaign.min_target + rand(20000..60000)
      campaign.loan_duration = rand(6..48)
      campaign.return_rate = rand(0.4..0.7)
      campaign.expiry_date = Date.today + rand(30..90).days

      campaign.company = company
      # campaign.investor_id = rand(User.first.id..User.last.id)
      campaign.save!



      10.times do
        reward = Reward.new()
        reward.description = "Campaign description.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore maiores, voluptatibus temporibus cupiditate dolorem, voluptate rem dicta aperiam tenetur. Facilis deleniti explicabo provident mollitia nulla inventore libero a consequuntur nemo."
        reward.investment_amount = AMOUNT.sample
        reward.campaign = campaign
        reward.save!


        rand(10..30).times do
          investment = Investment.new()
          investment.status = rand(0..4) #check enumerable in investment.rb (model)
          investment.amount = rand(30000..120000)
          investment.payment_date = campaign.expiry_date + (campaign.loan_duration * 30)
          # caution. enhance code as each investor should not have more than one investment on the same company.
          investment.investor = User.find_by(email: USERS[:investors].sample[:email])
          investment.campaign = campaign
          investment.reward = reward
          investment.save!
        end
      end
    end
  end
end

puts "seeds succesfully"
