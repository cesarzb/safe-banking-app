# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

3.times do |i|
  User.create(
    email: "bernard#{i + 1}@example.com",
    confirmed_at: Time.now.utc,
    password: 'SecurePassword1@',
    code: "0000111#{i}22223333",
    balance: 0.999997e9,
    variation_number: 0,
    login_attempts: 0,
    encrypted_credit_card: "412345678901234#{i}",
    encrypted_personal_id: "123-45-678#{i}"
    # Add other attributes as needed
  )
end
