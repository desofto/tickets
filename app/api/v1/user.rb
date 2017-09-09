# frozen_string_literal: true

module API
  module V1
    class User < Grape::API
      desc 'Clients list'
      get '/clients' do
        authorize! :index, ::Client

        clients = ::Client.all
        present :clients, paginate_collection(clients, params)
        present :total, clients.count
      end

      desc 'Agents list'
      get '/agents' do
        authorize! :index, ::Agent

        agents = ::Agent.all
        present :agents, paginate_collection(agents, params)
        present :total, agents.count
      end

      desc "Create an agent's account"
      params do
        requires :agent, type: Hash do
          requires :email, type: String
          requires :password, type: String
        end
      end
      post '/agents' do
        authorize! :create, ::Agent

        agent = Agent.create(email: params[:agent][:email], password: params[:agent][:password])

        present agent
      end
    end
  end
end
