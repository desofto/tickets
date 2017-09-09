# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.on :startup do
    Rails.logger = Sidekiq::Logging.logger
  end
end
