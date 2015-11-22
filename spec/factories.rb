require 'faker'

FactoryGirl.define do
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
  end
  factory :school do
    name "Success"
  end
end
