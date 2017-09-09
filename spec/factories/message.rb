FactoryGirl.define do
  factory :message do
    request
    author { create(:client) }
    body 'Sample of request'
  end
end
