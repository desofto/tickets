class RequestBroadcastJob < ApplicationJob
  queue_as :default

  def perform(request, is_new: false)
    queue =
      if is_new
        'new_requests_channel'
      else
        'requests_channel'
      end
    ActionCable.server.broadcast queue, request.id
  end
end
