require 'faker'

puts "Cleaning database"
Review.destroy_all
Job.destroy_all
Service.destroy_all
User.destroy_all

puts "Create test account for vendor"

testvendor = User.create!(email: 'vendor_test@hotmail.com',
                          password: '123456',
                          location: Faker::Address.city,
                          description: "I am your mama shop's worst nightmare.",
                          role: 'vendor',
                          handle: "testvendor")

testuser = User.create!(email: 'user_test@hotmail.com',
                          password: '123456',
                          location: Faker::Address.city,
                          description: "I am your mama shop's worst nightmare.",
                          role: 'user',
                          handle: "testuser")

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
  service.user = testvendor
  service.save!

    3.times do
    job = Job.new(
      description: Faker::Games::StreetFighter.quote,
      date: Faker::Date.in_date_period,
      location: Faker::Address.street_name,
      status: ["Not yet started", "In progress", "Completed"].sample
      )
    job.service = service
    job.user = testuser
    job.save!

    (3..5).to_a.sample.times do
      review = Review.new(
        rating: (1..5).to_a.sample,
        comment: Faker::Restaurant.review,
        )
      review.user = testuser
      review.job = job
      review.save!
    end
  end
end


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

puts "Creating 50 jobs and reviews..."
50.times do
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
      rating: (1..5).to_a.sample,
      comment: Faker::Restaurant.review,
      )
    review.user = User.all.where("role='user'").sample
    review.job = job
    review.save!
  end
end

puts "Finished creating 50 jobs and reviews..."
