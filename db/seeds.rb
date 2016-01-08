# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

5.times do
  user = User.create!(username: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Lorem.characters(8))
end

5.times do
  users = User.all
  description = Faker::Lorem.sentence(3)
  users.each { |user| user.items.create!(description: description) }
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Item.count} items created"
