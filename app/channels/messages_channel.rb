class MessagesChannel < ApplicationCable::Channel
  def subscribed
    queue = "messages_channel_#{params[:request_id]}"
    stream_from queue, -> (message) {
      next unless ability.can? :show, message
      transmit message, via: queue
    }
  end

  def unsubscribed
    stop_all_streams
  end
end
