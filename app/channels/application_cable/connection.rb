module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    def ability
      @ability ||= Ability::Factory.build_ability_for(current_user)
    end

    protected

    def find_verified_user
      verified_user = request.params[:auth_token] && User.find_by(auth_token: request.params[:auth_token])
      if verified_user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
