# frozen_string_literal: true

module API
  module V1
    class User < Grape::API
      desc 'Users list'
      get '/users' do
        authorize! :read, ::User
        'qwe'
      end

      desc 'Sign out'
      delete '/sign_out' do
        current_user.reset_authentication_token
        {}
      end
    end
  end
end
