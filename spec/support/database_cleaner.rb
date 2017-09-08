RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do |example|
    if example.metadata[:js]
      Capybara.current_driver = :webkit
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end
  end

  config.after(:each) do |example|
    Capybara.use_default_driver if example.metadata[:js]
    DatabaseCleaner.clean
  end
end
