class RequestsChannel < ApplicationCable::Channel
  def subscribed
    queue = 'requests_channel'
    stream_from queue, coder: ActiveSupport::JSON do |request_id|
      request = Request.find(request_id)
      next unless ability.can? :show, request
      data = { request: API::V1::Entities::Request.represent(request) }
      transmit data, via: queue
    end

    queue = 'new_requests_channel'
    stream_from queue, coder: ActiveSupport::JSON do |request_id|
      request = Request.find(request_id)
      next unless ability.can? :show, request
      data = { request: API::V1::Entities::Request.represent(request), is_new: true }
      transmit data, via: queue
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
