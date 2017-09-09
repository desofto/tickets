module API
  module V1
    module Entities
      class Message < Base
        expose :request do |message|
          { request_id: message.request_id }
        end

        expose :author do |message|
          {
            id: message.author.id,
            email: message.author.email
          }
        end

        expose :body
      end
    end
  end
end
