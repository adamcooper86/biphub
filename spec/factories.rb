FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
  end
  factory :admin do
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
  end
  factory :teacher do
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
  end
  factory :coordinator do
    first_name "John"
    last_name  "Doe"
    password "password"
    password_confirmation "password"
  end
  factory :speducator do
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
