module API
  module V1
    module Helpers
      module AuthHelpers
        def authenticate!
          authentication_token && current_user.present?
        end

        def current_user
          @current_user ||= authentication_token && ::User.find_by(auth_token: authentication_token)
        end

        def current_ability
          @current_ability ||= Ability::Factory.build_ability_for(current_user)
        end

        private

        def authentication_token
          @api_token ||= params[:auth_token]
        end
      end
    end
  end
end
