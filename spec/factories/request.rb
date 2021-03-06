FactoryGirl.define do
  factory :request do
    status 'open'
    client
    sequence(:subject) { |n| "Request #{n}" }

    trait :with_message do
      after(:create) do |request|
        create(:message, request: request)
      end
    end
  end
end
