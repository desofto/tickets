# frozen_string_literal: true

class ArchiveWorker
  include Sidekiq::Worker
  include SidekiqStatus::Worker

  def perform
    Request.where('updated_at < ?', 7.days.ago).each(&:archived!)
  end
end
