module Ability
  class Admin < Ability::Base
    def permissions
      can :manage, ::User
    end
  end
end
