module API
  module V1
    module Entities
      class Request < Base
        expose :subject

        expose :client
        expose :agent

        expose :opened, format_with: :iso_timestamp
        expose :closed, format_with: :iso_timestamp
        expose :archived, format_with: :iso_timestamp

        expose :messages
      end
    end
  end
end
