require 'faker'

FactoryGirl.define do
  factory :observation do
  end

  factory :record do
  end

  factory :goal do
  end

  factory :bip do
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
  end
  factory :coordinator do
    email Faker::Internet.email
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
  end
  factory :speducator do
    email Faker::Internet.email
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
  end
  factory :student do
    first_name "John"
    last_name  "Doe"
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
