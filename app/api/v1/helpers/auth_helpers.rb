module API
  module V1
    module Helpers
      module AuthHelpers
        def authenticate!
          authentication_token && current_user.present?
        end

        def current_user
          @current_user ||= User.find_by(auth_token: authentication_token) || authentication_error
        end

        private

        def authentication_token
          @api_token ||= params[:auth_token] || authentication_error
        end

        def authentication_error
          error!({ errors: ['Auth Token is not provided or invalid'], internal_error_code: '9999' }, 401)
        end
      end
    end
  end
end
