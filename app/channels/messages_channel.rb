class MessagesChannel < ApplicationCable::Channel
  def subscribed
    queue = "messages_channel_#{params[:request_id]}"
    stream_from queue, coder: ActiveSupport::JSON do |message_id|
      message = Message.find(message_id)
      next unless ability.can? :show, message
      transmit { message: API::V1::Entities::Message.represent(message) }, via: queue
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
