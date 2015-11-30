require 'faker'
#create the admin user

Admin.create(email: "admin@biphub.com", first_name: "Admin", last_name: "istrator", password: "abc123", password_confirmation: "abc123")
school = School.create(name: "Beverly Hills High", address: "123 TVLand Dr.", city: "Beverly Hills", state: "CA", zip: "90210")

coordinator = Coordinator.create(email: "coordinator@biphub.com", first_name: "Cory", last_name: "Nader", password: "abc123", password_confirmation: "abc123")
school.coordinators << coordinator

speducator = Speducator.create(email: "patch.adams@biphub.com", first_name: "Patch", last_name: "Adams", password: "abc123", password_confirmation: "abc123")
school.speducators << speducator

teacher = Teacher.create(email: "jryan@biphub.com", first_name: "Jack", last_name: "Ryan", password: "abc123", password_confirmation: "abc123")
school.teachers << teacher

7.times do
  Teacher.create email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "abc123", password_confirmation: "abc123", school_id: school.id
end

8.times do
  student = Student.create first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, speducator_id: speducator.id, school_id: school.id

  Teacher.all.each do |teacher|
    time = Faker::Time.forward(1, :day)
    card = Card.create user_id: teacher.id, start: time, end: time + 60
    student.cards << card
  end

  bip = Bip.create
  student.bips << bip
  bip.goals << [Goal.create, Goal.create, Goal.create]
end

Student.create_daily_records

puts "Successfully Seeded the Database"