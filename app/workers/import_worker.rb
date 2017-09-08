# frozen_string_literal: true

class ImportWorker
  include Sidekiq::Worker
  include SidekiqStatus::Worker

  def perform(file_name)
    self.payload = {}
    return unless File.exists? file_name
    ::OperationsImporter.new(file_name).import do |info|
      self.payload = info
    end
  rescue Errno::ENOENT, CSV::MalformedCSVError
    # Do not continue if file cannot be processed
  end
end
