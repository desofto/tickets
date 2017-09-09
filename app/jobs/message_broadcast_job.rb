class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    queue = "messages_channel_#{message.request_id}"
    ActionCable.server.broadcast queue, message: message
  end
end
