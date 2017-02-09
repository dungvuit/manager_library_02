# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
30.times do |n|
  email = "user#{n}@gmail.com"
  password = "123456789"
  password_confirmation = "123456789"
  name = "User#{n}"
  phonenumber = Faker::PhoneNumber.phone_number
  user = User.create email: email, password: password,
    password_confirmation: password_confirmation, name: name, phonenumber: phonenumber
end

20.times do |n|
  name = Faker::Book.publisher
  address = Faker::Address.street_address
  phonenumber = Faker::PhoneNumber.phone_number
  description = Faker::Lorem.sentence 5
  pubisher = Publisher.create name: name, address: address,
    phone: phonenumber, description: description
end

10.times do |n|
  name = Faker::Book.genre
  category = Category.create name: name
end

40.times do |n|
  name = Faker::Book.author
  address = Faker::Address.street_address
  description = Faker::Lorem.sentence 5
  publisher_id = Publisher.all.sample.id
  author = Author.create name: name, address: address, description: description,
    publisher_id: publisher_id
end

100.times do |n|
  name = Faker::Book.title
  publisher_year = Faker::Date.between_except(100.year.ago, 1.year.from_now, Date.today).year
  description = Faker::Lorem.sentence 5
  publisher_id = Publisher.all.sample.id
  book = Book.create name: name, publisher_year: publisher_year, publisher_id: publisher_id,
    description: description
  book.authors << Author.all.sample
  book.categories << Category.all.sample
end
