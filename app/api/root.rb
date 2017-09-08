# frozen_string_literal: true

module API
  class Root < Grape::API
    helpers API::V1::Helpers::AuthHelpers
    mount API::V1::Root
  end
end
