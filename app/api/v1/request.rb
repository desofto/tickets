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
          end
        end
        post do
          authorize! :create, ::Request

          request = ::Request.create(client: current_user, subject: params[:request][:subject])
          message = request.messages.create(body: params[:request][:body])
          present request
        end

        desc "Request's messages"
        route_param :request_id do
          helpers do
            def support_request
              @support_request ||= ::Request.accessible_by(current_ability).find(params[:request_id])
            end
          end

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

            support_request.messages.create(body: params[:message][:body])

            present 'ok'
            status :created
          end

          desc 'Take request'
          put 'take' do
            authorize! :take, support_request

            support_request.update!(agent: current_user)

            present support_request
          end

          desc 'Close request'
          put 'close' do
            authorize! :close, support_request

            support_request.close!

            present support_request
          end

          desc 'Open request'
          put 'open' do
            authorize! :open, support_request

            support_request.open!

            present support_request
          end

          desc 'Archive request'
          put 'archive' do
            authorize! :archive, support_request

            support_request.archive!

            present support_request
          end
        end
      end
    end
  end
end
