require 'faker'

puts "Cleaning database"
Job.destroy_all
Review.destroy_all
Service.destroy_all
User.destroy_all

puts "Create test account for vendor"

testvendor = User.create!(email: 'test@hotmail.com',
                          password: '123456',
                          location: Faker::Address.city,
                          description: "I am your mama shop's worst nightmare.",
                          role: 'vendor',
                          handle: "testvendor")

puts "Creating 50 vendors and service offerings..."
50.times do
  vendor = User.new(
    email: Faker::Internet.email,
    password: '123456',
    location: Faker::Address.city,
    description: [
      "I eat code for breakfast lunch and dinner.",
      "Sometimes I wake up and think that I am banksy...",
      "I am your mama shop's worst nightmare.",
      "I sometimes like to rob the food pantry... Just for fun",
      "I will kill any gummy bear, if you pay me enough.",
      "Breaking into any doll house is my specialty"
    ].sample,
    role: "vendor",
    handle: Faker::Twitter.screen_name)
  vendor.save!

  (5..10).to_a.sample.times do
    service = Service.new(
      name: [
        "Steal all your candies",
        "Rob the piggy bank",
        "Kill Buzzlightyear",
        "Hack into your Lewagon student profile",
        "Peddle competitively priced drugs to the local doctor",
        "Spray paint your living room wall with your favorite color theme",
      ].sample,
      price: Faker::Commerce.price,
      category: ['Burglary', 'Cybercrime', 'Drugs', 'Harassment', 'Homicide', 'Theft', 'Vandalism'].sample
    )
    service.user = vendor
    service.save!
  end
end

puts "Finished creating 50 vendors and service offerings."

puts "Creating 50 users..."
50.times do
  user = User.new(
    email: Faker::Internet.email,
    password: '123456',
    location: Faker::Address.city,
    description: Faker::Movies::StarWars.quote,
    role: "user",
    handle: Faker::Twitter.screen_name)
  user.save!
end

puts "Finished creating 50 users."

puts "Creating 100 jobs and reviews..."
100.times do
  job = Job.new(
    description: Faker::Games::StreetFighter.quote,
    date: Faker::Date.in_date_period,
    location: Faker::Address.street_name,
    status: ["Not yet started", "In progress", "Completed"].sample
    )
  job.service = Service.all.sample
  job.user = User.all.where("role='vendor'").sample
  job.save!

  (3..10).to_a.sample.times do
    review = Review.new(
      rating: (0..5).to_a.sample,
      comment: Faker::Restaurant.review,
      )
    review.user = User.all.where("role='vendor'").sample
    review.job = job
  end
end

puts "Finished creating 100 jobs and reviews..."

# job1 = Job.new(description: "My boss's email address is smellycat@nyc.com",
#                           date: Faker::Date.forward(days: 23),
#                           location: '96 Cove Drive, Singapore',
#                           status: "In progress")
# job1.service = service1
# job1.user = user1
# job1.save!

# job2 = Job.new(description: "Paint my company logo in bright orange, on the side of International Building.",
#                           date: Faker::Date.forward(days: 14),
#                           location:'92 Cove Drive, Singapore',
#                           status: "Completed")
# job2.service = service3
# job2.user = user2
# job2.save!
# puts "Finished creating 2 jobs"


# puts "Creating 3 users..."
# user1 = User.create!(email: Faker::Internet.email,
#                       password: '234566',
#                       location: Faker::Address.city,
#                       description: Faker::Lorem.sentence,
#                       role: 'user',
#                       handle: Faker::Internet.username)

# user2 = User.create!(email: Faker::Internet.email,
#                       password: '234566',
#                       location: Faker::Address.city,
#                       description: Faker::Lorem.sentence,
#                       role: 'user',
#                       handle: Faker::Internet.username)

# user3 = User.create!(email: Faker::Internet.email,
#                       password: '234566',
#                       location: Faker::Address.city,
#                       description: Faker::Lorem.sentence,
#                       role: 'user',
#                       handle: Faker::Internet.username)
# puts "Finished creating 3 users."

# puts "Creating 3 services..."
# service1 = Service.new(name: "Will hack into your boss's email.",
#                           price: Faker::Commerce.price,
#                           category: "Cybercrime")

# service1.user = vendor1
# service1.save!

# service2 = Service.new(name: "Will steal TWO (2) chocolate bars.",
#                           price: Faker::Commerce.price,
#                           category: "Theft")

# service2.user = vendor2
# service2.save!

# service3 = Service.new(name: "Will spray paint a public building in the colour of your choice.",
#                           price: Faker::Commerce.price,
#                           category: "Vandalism")

# service3.user = vendor3
# service3.save!
# puts "Finished creating 3 services."

# puts "Creating 2 jobs..."
# job1 = Job.new(description: "My boss's email address is smellycat@nyc.com",
#                           date: Faker::Date.forward(days: 23),
#                           location: '96 Cove Drive, Singapore',
#                           status: "In progress")
# job1.service = service1
# job1.user = user1
# job1.save!

# job2 = Job.new(description: "Paint my company logo in bright orange, on the side of International Building.",
#                           date: Faker::Date.forward(days: 14),
#                           location:'92 Cove Drive, Singapore',
#                           status: "Completed")
# job2.service = service3
# job2.user = user2
# job2.save!
# puts "Finished creating 2 jobs"

# puts "Creating 1 review..."
# review1 = Review.new(rating: 5,
#                           comment: "The graffiti was very ugly. 5 stars.")
# review1.user = user2
# review1.job = job2
# review1.save!
# puts "Finished creating 1 review."
