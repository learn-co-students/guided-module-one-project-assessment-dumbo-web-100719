#create a random list of users

User.destroy_all
Bike.destroy_all
User.reset_pk_sequence
Bike.reset_pk_sequence

10.times do |index|
User.create(name: Faker::Name.name, 
            phone_number: Faker::PhoneNumber.cell_phone, 
            email: Faker::Internet.email, 
            looking_for: "Any Bikes, any condition")
end