require 'faker'

FactoryGirl.define do
  factory :observation do
    student
    user
    start { Time.now }
    finish { Time.now + 60 }
  end

  factory :record do
    observation
    goal
  end

  factory :goal do
    bip
    text "Goals Text"
    prompt "Goal Prompt"
    meme "Time"
  end

  factory :bip do
    student
    start Date.today
    finish Date.tomorrow
  end

  factory :card do
    user
    student
    start { Time.now }
    finish { Time.now + 60 }
  end

  factory :user do
    email Faker::Internet.email
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
  end
  factory :admin do
    email Faker::Internet.email
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
  end
  factory :teacher do
    email Faker::Internet.email
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
    school
  end
  factory :coordinator do
    email Faker::Internet.email
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
    school
  end
  factory :speducator do
    email Faker::Internet.email
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
    school
  end
  factory :student do
    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    school
  end
  factory :school do
    name "Success"
    address "2011 Bienville St"
    city "New Orleans"
    state "LA"
    zip "70112"
  end
end
