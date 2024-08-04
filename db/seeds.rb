# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

# Clear existing data
User.destroy_all

# Create users with different roles
users = [
  {
    email: 'user@example.com',
    password: 'password',
    role: :user
  },
  {
    email: 'dev@example.com',
    password: 'password',
    role: :dev
  },
  {
    email: 'analytic@example.com',
    password: 'password',
    role: :analytic
  },
  {
    email: 'admin@example.com',
    password: 'password',
    role: :admin
  }
]

users.each do |user_attributes|
  User.create!(user_attributes)
end

puts "Created #{User.count} users."
