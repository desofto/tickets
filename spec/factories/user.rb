FactoryGirl.define do
  factory :user do
    type 'User'
    sequence(:email) { |n| "test_#{n}@gmail.com" }
    password 'qweqwe'

    after(:create) do |user|
      user.reset_authentication_token
    end

    factory :client do
      type 'Client'
    end

    factory :agent do
      type 'Agent'
    end

    factory :admin do
      type 'Admin'
    end
  end
end
