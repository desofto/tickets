FactoryGirl.define do
  factory :request do
    client
    sequence(:subject) { |n| "Request #{n}" }
  end
end
