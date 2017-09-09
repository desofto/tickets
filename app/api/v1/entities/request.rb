module API
  module V1
    module Entities
      class Request < Base
        expose :subject

        expose :status

        expose :client do |request|
          {
            id: request.client.id,
            email: request.client.email
          }
        end

        expose :agent do |request|
          next if request.agent.blank?
          { id: request.agent_id }
        end

        expose :opened, format_with: :iso_timestamp, if: -> (request, opts) { request.opened.present? }
        expose :closed, format_with: :iso_timestamp, if: -> (request, opts) { request.closed.present? }
        expose :archived, format_with: :iso_timestamp, if: -> (request, opts) { request.archived.present? }

        expose :messages, with: API::V1::Entities::Message, unless: -> (request, opts) { opts[:collection] }

        expose :messages_count do |request|
          request.messages.count
        end
      end
    end
  end
end
