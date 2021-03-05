require 'faker'

puts "Cleaning database"
Job.destroy_all
Review.destroy_all
Service.destroy_all
User.destroy_all

puts "Creating 3 vendors..."
vendor1 = User.create!(email: Faker::Internet.email,
                      password: '123456',
                      location: Faker::Address.city,
                      description: "I eat code for breakfast lunch and dinner.",
                      role: "vendor",
                      handle: "anonymouse168")

vendor2 = User.create!(email: Faker::Internet.email,
                      password: '324123',
                      location: Faker::Address.city,
                      description: "I am your mama shop's worst nightmare.",
                      role: 'vendor',
                      handle: "kindernotbueno")

vendor3 = User.create!(email: Faker::Internet.email,
                      password: '823434',
                      location: Faker::Address.city,
                      description: "Sometimes I wake up and think that I am banksy...",
                      role: 'vendor',
                      handle: "wallbanana62")
puts "Finished creating 3 vendors."

puts "Creating 3 users..."
user1 = User.create!(email: Faker::Internet.email,
                      password: '234566',
                      location: Faker::Address.city,
                      description: Faker::Lorem.sentence,
                      role: 'user',
                      handle: Faker::Internet.username)

user2 = User.create!(email: Faker::Internet.email,
                      password: '234566',
                      location: Faker::Address.city,
                      description: Faker::Lorem.sentence,
                      role: 'user',
                      handle: Faker::Internet.username)

user3 = User.create!(email: Faker::Internet.email,
                      password: '234566',
                      location: Faker::Address.city,
                      description: Faker::Lorem.sentence,
                      role: 'user',
                      handle: Faker::Internet.username)
puts "Finished creating 3 users."

puts "Creating 3 services..."
service1 = Service.new(name: "Will hack into your boss's email.",
                          price: Faker::Commerce.price,
                          category: "Cybercrime")

service1.user = vendor1
service1.save!

service2 = Service.new(name: "Will steal TWO (2) chocolate bars.",
                          price: Faker::Commerce.price,
                          category: "Theft")

service2.user = vendor2
service2.save!

service3 = Service.new(name: "Will spray paint a public building in the colour of your choice.",
                          price: Faker::Commerce.price,
                          category: "Vandalism")

service3.user = vendor3
service3.save!
puts "Finished creating 3 services."

puts "Creating 2 jobs..."
job1 = Job.new(description: "My boss's email address is smellycat@nyc.com",
                          date: Faker::Date.forward(days: 23),
                          location: Faker::Address.city,
                          status: "In progress")
job1.service = service1
job1.user = user1
job1.save!

job2 = Job.new(description: "Paint my company logo in bright orange, on the side of International Building.",
                          date: Faker::Date.forward(days: 14),
                          location: Faker::Address.city,
                          status: "Completed")
job2.service = service3
job2.user = user2
job2.save!
puts "Finished creating 2 jobs"

puts "Creating 1 review..."
review1 = Review.new(rating: 5,
                          comment: "The graffiti was very ugly. 5 stars.")
review1.user = user2
review1.job = job2
review1.save!
puts "Finished creating 1 review."
