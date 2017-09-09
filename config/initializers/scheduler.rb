# frozen_string_literal: true

require 'sidekiq/scheduler'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq::Scheduler.enabled = true
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../scheduler.yml', __FILE__))
    Sidekiq::Scheduler.reload_schedule!
  end
end
