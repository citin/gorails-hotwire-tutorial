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
User.create(email_address: 'user@example.com', password: 'password123', password_confirmation: 'password123')
User.create(email_address: 'user2@example.com', password: 'password123', password_confirmation: 'password123')

puts 'Creating posts...'
5.times do |i|
  Post.create(body: "Post #{i + 1}: #{Faker::Lorem.paragraph(sentence_count: 5)}", author: User.first)
  Post.create(body: "Post #{i + 1}: #{Faker::Lorem.paragraph(sentence_count: 5)}", author: User.last)
end
