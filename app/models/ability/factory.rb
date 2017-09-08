module Ability
  class Factory
    def self.build_ability_for(user)
      case user&.type
      when 'Admin'  then Ability::Admin.new(user)
      when 'Client' then Ability::Client.new(user)
      when 'Agent'  then Ability::Agent.new(user)
      else               Ability::User.new(user)
      end
    end
  end
end
