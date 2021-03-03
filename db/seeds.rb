require 'faker'

puts "Cleaning database"
Job.destroy_all
Review.destroy_all
Service.destroy_all
User.destroy_all

puts "Creating Vendor1"
vendor1 = User.create!(email: Faker::Internet.email,
                      password: '123456',
                      location: Faker::Address.city,
                      description: Faker::Lorem.sentence,
                      role: 'vendor',
                      handle: "Vendor1")

puts "Finished creating Vendor1"

puts "Creating User1"
user1 = User.create!(email: Faker::Internet.email,
                      password: '234566',
                      location: Faker::Address.city,
                      description: Faker::Lorem.sentence,
                      role: 'user',
                      handle: "User1")

puts "Finished creating User1"

puts "Creating Hacking Service"
hacking = Service.new(name: "Will hack into your boss's email.",
                          price: Faker::Commerce.price,
                          category: "Cybercrime")

hacking.user = vendor1
hacking.save!

puts "Finished creating Hacking Service, linked to Vendor 1"

puts "Creating Hacking Job"
hacking_job = Job.new(description: "My boss's email address is smellycat@nyc.com",
                          date: Faker::Date.forward(days: 23),
                          location: Faker::Address.city,
                          status: "In progress")
hacking_job.service = hacking
hacking_job.user = user1
hacking_job.save!

puts "Finished creating Hacking Service, linked to Hacking Service and User1"

puts "Creating Review 1"
review1 = Review.new(rating: 5,
                          comment: "Much hacking. Much wow. 5 stars.")
review1.user = user1
review1.job = hacking_job
review1.save!
