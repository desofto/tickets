RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = false
  end

  config.order = :random
  Kernel.srand config.seed

  config.default_formatter = 'doc' if config.files_to_run.one?
end
