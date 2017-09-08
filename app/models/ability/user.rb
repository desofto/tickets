module Ability
  class User < Ability::Base
    def permissions
      can :create, Request
    end
  end
end
