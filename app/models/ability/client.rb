module Ability
  class Client < Ability::Base
    def permissions
      cannot :index,   ::Client
      cannot :create,  ::Client
      cannot :update,  ::Client
      cannot :delete,  ::Client

      cannot :index,   ::Agent
      cannot :create,  ::Agent
      cannot :update,  ::Agent
      cannot :delete,  ::Agent

      can :index,   ::Request, client: @user
      can :create,  ::Request
      can :show,    ::Request, client: @user
      can :update,  ::Request, client: @user
      cannot :take, ::Request
      can :close,   ::Request, client: @user
      can :open,    ::Request, client: @user
      cannot :archive, ::Request

      can :show,    ::Message do |message|
        message.client_id == @user.id
      end
    end
  end
end
