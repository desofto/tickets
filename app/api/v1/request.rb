# frozen_string_literal: true

module API
  module V1
    class Request < Grape::API
      resources :requests do
        desc 'Requests list'
        params do
          optional :status, type: String, values: %w(open closed archived)
        end
        get do
          authorize! :index, ::Request

          # for agent it will show both unassigned and own requests
          # for client it will show only own requests
          requests = ::Request.accessible_by(current_ability)
          case params[:status]
          when 'open' then requests = requests.open
          when 'closed' then requests = requests.closed
          when 'archived' then requests = requests.archived
          end

          present :requests, paginate_collection(requests, params)
          present :total, requests.count
        end

        desc 'Create new request'
        params do
          requires :request, type: Hash do
            requires :subject, type: String
            requires :body, type: String
            optional :email, type: String
          end
          optional :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
          end
        end
        post do
          authorize! :create, ::Request

          client = current_user

          if !client && params[:user].present?
            # in case it is not authenticated client, try to create an account (e-mail will be sent)
            client = Client.create!(email: params[:user][:email], password: params[:user][:password])
            alert = 'Account was created. Please check your email and click a link'
          end

          request = ::Request.create!(client: client, subject: params[:request][:subject])
          message = request.messages.create!(author: client, body: params[:request][:body])

          present alert || request
        end

        desc 'Methods related to particular request'
        route_param :request_id do
          helpers do
            def support_request
              @support_request ||= ::Request.accessible_by(current_ability).find(params[:request_id])
            end
          end

          desc 'Get a single request'
          get do
            authorize! :show, support_request

            present support_request
          end

          desc "Get request's messages"
          get 'messages' do
            authorize! :show, support_request

            messages = support_request.messages
            present :messages, paginate_collection(messages, params)
            present :total, messages.count
          end

          desc 'Add new message'
          params do
            requires :message, type: Hash do
              requires :body, type: String
            end
          end
          post 'messages' do
            authorize! :update, support_request

            # assign request to an agent if any
            support_request.update!(agent: current_user) if support_request.agent.blank? && current_user.agent?

            support_request.messages.create(author: current_user, body: params[:message][:body])

            # re-open request in case it is client or make request 'answered' if it is either agent or admin
            if current_user.client?
              support_request.open!
            elsif current_user.agent? || current_user.admin?
              support_request.answered!
            end

            present 'ok'
            status :created
          end

          desc 'Take request'
          put 'take' do
            authorize! :take, support_request

            # assign request to an agent
            support_request.update!(agent: current_user) if support_request.agent.blank?

            present support_request
          end

          desc 'Close request'
          put 'close' do
            authorize! :close, support_request

            # close an request from the client side
            support_request.closed!

            present support_request
          end

          desc 'Archive request'
          put 'archive' do
            authorize! :archive, support_request

            # archive request by admin
            support_request.archived!

            present support_request
          end
        end
      end
    end
  end
end
