# frozen_string_literal: true

module API
  module V1
    class Root < Grape::API
      include API::Exceptions

      version 'v1', using: :path
      format :json

      mount API::V1::Auth

      before do
        authenticate!
      end

      mount API::V1::Ping
    end
  end
end
