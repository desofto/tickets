module Ability
  class Base
    include CanCan::Ability

    def initialize(user)
      @user = user

      permissions
    end

    def permissions
      raise NotImplementedError
    end
  end
end
