module Ability
  class Agent < Ability::Base
    def permissions
      cannot :index,   ::Client
      cannot :create,  ::Client
      cannot :update,  ::Client
      cannot :delete,  ::Client

      cannot :index,   ::Agent
      cannot :create,  ::Agent
      cannot :update,  ::Agent
      cannot :delete,  ::Agent

      can %i(index show take), ::Request, ['agent_id IS NULL OR agent_id = ?', @user.id] do |request|
        request.agent.blank? || request.agent.id == @user.id
      end

      cannot :create,  ::Request
      cannot :update,  ::Request
      cannot :close,   ::Request
      cannot :open,    ::Request
      cannot :archive, ::Request

      can :show,    ::Message do |message|
        message.agent_id.blank? || message.agent_id == @user.id
      end
    end
  end
end
