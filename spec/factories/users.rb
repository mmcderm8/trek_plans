FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    admin false
  end
end
