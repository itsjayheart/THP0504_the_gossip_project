# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
City.destroy_all

User.destroy_all

Gossip.destroy_all

Tag.destroy_all

10.times do
  City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

10.times do
  User.create(city: City.all[rand(9)], first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence(word_count: rand(10..20)), email: Faker::Internet.email, age: rand(15..89))
end

tags_title_array = ["hot_box", "munchies", "sorry_not_sorry","Oopsie_I_made_a_poopsie","So_Santa_Barbara","cool_story_bro", "ok_boomer", "amour_haine_et_aisne", "BLM", "les_patates_sont_cuites"]

10.times do
  Tag.create(title: tags_title_array.sample)
end

20.times do
  Gossip.create(title: Faker::Lorem.sentence(word_count: rand(1..3)), content: Faker::Lorem.sentence(word_count: rand(10..20)), user: User.all.sample)
end

Gossip.all.each do |gossip|
  Tag.all.each do |tag|
    i = rand(0..1)
    if i == 0
      JoinTableGossipTag.create!(tag: tag, gossip: gossip)
    end
  end
end

users_array = User.all

5.times do
  PrivateMessage.create(content: Faker::Lorem.sentence(word_count: rand(10..20)), sender: users_array.sample, recipient: users_array.sample)
end
