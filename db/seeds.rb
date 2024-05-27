# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Clearing out your junk..."
Restaurant.destroy_all

puts "Creating restaurants..."
categories = %w(chinese italian japanese french belgian)
10.times do
  attributes = { name: Faker::Restaurant.name, address: Faker::Address.full_address, phone_number: Faker::PhoneNumber.cell_phone_in_e164, category: categories.sample }
  restaurant = Restaurant.create!(attributes)
  puts "Created #{restaurant.name}"
  3.times do
    attributes = { restaurant_id: restaurant.id, rating: (0..5).to_a.sample, content: Faker::Fantasy::Tolkien.poem }
    review = Review.create!(attributes)
    p restaurant
    p review
    review.restaurant_id = restaurant
    puts "Created #{review.id}"
  end
end

puts "Finished!"
