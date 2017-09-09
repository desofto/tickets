# frozen_string_literal: true

module API
  module V1
    class Root < Grape::API
      include API::Exceptions

      version 'v1', using: :path
      format :json

      rescue_from ActiveRecord::RecordNotFound do
        error_response message: '404 not found', status: 404
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error!({ errors: [e.message] }, 422)
      end

      rescue_from CanCan::AccessDenied do
        error!({ errors: ['You are not authorized to this resource'] }, 403)
      end

      helpers API::V1::Helpers::PaginationHelpers

      represent ::User, with: API::V1::Entities::User
      represent ::Admin, with: API::V1::Entities::User
      represent ::Client, with: API::V1::Entities::User
      represent ::Agent, with: API::V1::Entities::User

      represent ::Request, with: API::V1::Entities::Request
      represent ::Message, with: API::V1::Entities::Message

      mount API::V1::Auth

      before do
        authenticate!
      end

      mount API::V1::User
      mount API::V1::Request

      mount API::V1::Ping
    end
  end
end
