module Ability
  class User < Ability::Base
    def permissions
      cannot :index,   ::Client
      cannot :create,  ::Client
      cannot :update,  ::Client
      cannot :delete,  ::Client

      cannot :index,   ::Agent
      cannot :create,  ::Agent
      cannot :update,  ::Agent
      cannot :delete,  ::Agent

      cannot :index,   ::Request
      can :create,  ::Request
      cannot :show,    ::Request
      cannot :update,  ::Request
      cannot :take,    ::Request
      cannot :close,   ::Request
      cannot :open,    ::Request
      cannot :archive, ::Request
    end
  end
end
