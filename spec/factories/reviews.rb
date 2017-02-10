FactoryGirl.define do
  factory :review do
    association :reviewer, factory: :user
    association :activity, factory: :activity
    rating 3
    sequence(:body) { |n| "This is awesome #{n}" }
    sum_votes 0
  end
end
