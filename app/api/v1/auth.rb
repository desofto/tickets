# frozen_string_literal: true

module API
  module V1
    class Auth < Grape::API
      helpers do
        def user
          return @user if @user.present?

          return unless params[:email]

          user = ::User.find_by(email: params[:email])
          error!({ errors: ['Invalid Email or Password.'] }, 401) unless user && user.valid_password?(params[:password])

          @user ||= user
        end
      end

      desc 'Sign In'
      post '/sign_in' do
        if user
          # reset the token
          user.reset_authentication_token
          status :created
          present user, with: API::V1::Entities::Me
        else
          unauthorized!(['Please check your credentials to proceed'])
        end
      end

      desc 'Sign out'
      delete '/sign_out' do
        # reset the token again, so nobody could use it
        current_user.reset_authentication_token
        {}
      end
    end
  end
end
