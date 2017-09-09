class RequestsChannel < ApplicationCable::Channel
  def subscribed
    queue = 'requests_channel'
    stream_from queue, -> (request) {
      next unless ability.can? :show, request
      transmit request, via: queue
    }
  end

  def unsubscribed
    stop_all_streams
  end
end
