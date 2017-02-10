FactoryGirl.define do
  factory :activity do
    association :creator, factory: :user
    sequence(:name) { |n| "Harrods shopping in london #{n}" }
    description "This is a test activity"
    image './fixtures/myfiles/omom.jpg'
  end
end
