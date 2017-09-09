class RequestsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'requests_channel', coder: ActiveSupport::JSON do |request_id|
      request = Request.find(request_id)
      next unless ability.can? :show, request
      data = { request: API::V1::Entities::Request.represent(request) }
      transmit data, via: 'requests_channel'
    end

    stream_from 'new_requests_channel', coder: ActiveSupport::JSON do |request_id|
      request = Request.find(request_id)
      next unless ability.can? :show, request
      data = { request: API::V1::Entities::Request.represent(request), is_new: true }
      transmit data, via: 'requests_channel'
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
