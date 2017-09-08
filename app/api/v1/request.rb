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

          requests = ::Request.all
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
            def request
              @request ||= ::Request.find(params[:request_id])
            end
          end

          get 'messages' do
            authorize! :show, request

            messages = request.messages
            present :messages, paginate_collection(messages, params)
            present :total, messages.count
          end

          desc 'Add new message'
          params do
            requires :message, type: Hash do
              requires :body, type: String
            end
          end
          post do
            authorize! :update, request

            request.messages.create(body: params[:message][:body])

            present 'ok'
            status :created
          end

          desc 'Take request'
          post 'take' do
            authorize! :take, request

            request.update!(agent: current_user)

            present request
          end

          desc 'Close request'
          post 'close' do
            authorize! :close, request

            request.close!

            present request
          end

          desc 'Open request'
          post 'open' do
            authorize! :open, request

            request.open!

            present request
          end

          desc 'Archive request'
          post 'archive' do
            authorize! :archive, request

            request.archive!

            present request
          end
        end
      end
    end
  end
end
