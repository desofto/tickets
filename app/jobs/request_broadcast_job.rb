class RequestBroadcastJob < ApplicationJob
  queue_as :default

  def perform(request)
    queue = 'requests_channel'
    ActionCable.server.broadcast queue, request: request
  end
end
