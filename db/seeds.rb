# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Creating users...'
user_1 = User.create(email_address: 'user@example.com', password: 'password', password_confirmation: 'password')
user_2 = User.create(email_address: 'user2@example.com', password: 'password', password_confirmation: 'password')

puts 'Creating topics...'
topic_1 = Topic.create(name: 'Cars')
topic_2 = Topic.create(name: 'Food')

puts 'Creating posts...'
15.times do |i|
  topic = Topic.all.sample
  user = User.all.sample
  Post.create(body: "#{ topic.name }: Post #{i + 1}: #{Faker::Lorem.paragraph(sentence_count: 5)}", author: user, topic: topic)
end
