module Ability
  class Admin < Ability::Base
    def permissions
      can :manage,  :all

      can :index,   ::Client
      can :create,  ::Client
      can :update,  ::Client
      can :delete,  ::Client

      can :index,   ::Agent
      can :create,  ::Agent
      can :update,  ::Agent
      can :delete,  ::Agent

      can :index,   ::Request
      can :create,  ::Request
      can :show,    ::Request
      can :update,  ::Request
      can :take,    ::Request
      can :close,   ::Request
      can :open,    ::Request
      can :archive, ::Request

      can :show,    ::Message
    end
  end
end
