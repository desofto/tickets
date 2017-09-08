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
    end
  end
end
