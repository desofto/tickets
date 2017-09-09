class RequestBroadcastJob < ApplicationJob
  queue_as :default

  def perform(request, is_new: false)
    queue = 'requests_channel'
    ActionCable.server.broadcast queue, request: API::V1::Entities::Request.represent(request), is_new: is_new
  end
end
