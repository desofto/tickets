require 'rails_helper'

describe API::V1::Request, type: :api do
  let(:admin) { create(:admin) }
  let(:agent) { create(:agent) }
  let(:another_agent) { create(:agent) }
  let(:client) { create(:client) }
  let(:another_client) { create(:client) }

  describe 'GET /api/v1/requests' do
    context 'admin' do
      it 'sees all requests' do
        create_list(:request, 2)

        get "/api/v1/requests?auth_token=#{admin.auth_token}&per_page=1"

        expect(response.status).to eq 200
        expect(json['requests'].count).to eq 1
        expect(json['total']).to eq 2
      end
    end

    context 'agent' do
      it 'sees only own and unassigned requests' do
        unassigned_id = create(:request).id
        own_id = create(:request, agent: agent).id
        create(:request, agent: another_agent)

        get "/api/v1/requests?auth_token=#{agent.auth_token}"

        expect(response.status).to eq 200
        request_ids = json['requests'].map { |r| r['id'] }
        expect(request_ids).to match_array [unassigned_id, own_id]
      end
    end

    context 'client' do
      it 'sees only own requests' do
        create(:request).id
        own_id = create(:request, client: client).id
        create(:request, client: another_client)

        get "/api/v1/requests?auth_token=#{client.auth_token}"

        expect(response.status).to eq 200
        request_ids = json['requests'].map { |r| r['id'] }
        expect(request_ids).to match_array [own_id]
      end
    end
  end

  describe 'POST /api/v1/requests' do
    context 'client' do
      it 'creates requests' do
        data = {
          subject: 'test',
          body: 'some message'
        }

        expect do
          post "/api/v1/requests?auth_token=#{client.auth_token}", params: { request: data }
        end.to change(Request, :count).by(1)

        expect(response.status).to eq 201
        id = json['id']
        request = Request.find(id)
        expect(request.subject).to eq data[:subject]
        expect(request.messages.count).to eq 1
        expect(request.messages.take.body).to eq data[:body]
      end
    end
  end

  describe 'GET /api/v1/requests/:id/messages' do
    context 'admin' do
      it 'returns messages connected to request' do
        req = create(:request, :with_message)

        get "/api/v1/requests/#{req.id}/messages?auth_token=#{admin.auth_token}"

        expect(response.status).to eq 200
        expect(json['messages'].count).to eq 1
        expect(json['messages'].first['body']).to eq 'Sample of request'
      end
    end
  end

  describe 'POST /api/v1/requests/:id/messages' do
    context 'client' do
      it 'appends message to request' do
        req = create(:request, client: client)

        data = {
          body: 'another message'
        }

        expect do
          post "/api/v1/requests/#{req.id}/messages?auth_token=#{client.auth_token}", params: { message: data }
        end.to change(req.messages, :count).by(1)

        expect(response.status).to eq 201
        expect(req.messages.take.body).to eq 'another message'
      end
    end
  end

  describe 'PUT /api/v1/requests/:id/take' do
    context 'agent' do
      it 'can take unassigned request' do
        req = create(:request)

        put "/api/v1/requests/#{req.id}/take?auth_token=#{agent.auth_token}"

        expect(response.status).to eq 200
        expect(req.reload.agent.id).to eq agent.id
      end

      it 'cannot take foreign request' do
        req = create(:request, agent: another_agent)

        put "/api/v1/requests/#{req.id}/take?auth_token=#{agent.auth_token}"

        expect(response.status).to eq 404
      end
    end
  end

  describe 'PUT /api/v1/requests/:id/close' do
    context 'client' do
      it 'can close own request' do
        req = create(:request, client: client)

        put "/api/v1/requests/#{req.id}/close?auth_token=#{client.auth_token}"

        expect(response.status).to eq 200
        expect(req.reload.closed).not_to be_blank
      end

      it 'cannot close foreign request' do
        req = create(:request, client: another_client)

        put "/api/v1/requests/#{req.id}/close?auth_token=#{client.auth_token}"

        expect(response.status).to eq 404
      end
    end
  end

  describe 'PUT /api/v1/requests/:id/open' do
    context 'client' do
      it 'can re-open own request' do
        req = create(:request, closed: Time.zone.now, client: client)

        put "/api/v1/requests/#{req.id}/open?auth_token=#{client.auth_token}"

        expect(response.status).to eq 200
        expect(req.reload.closed).to be_blank
      end

      it 'cannot close foreign request' do
        req = create(:request, closed: Time.zone.now, client: another_client)

        put "/api/v1/requests/#{req.id}/open?auth_token=#{client.auth_token}"

        expect(response.status).to eq 404
      end
    end
  end

  describe 'PUT /api/v1/requests/:id/archive' do
    context 'admin' do
      it 'can arhive request' do
        req = create(:request)

        put "/api/v1/requests/#{req.id}/archive?auth_token=#{admin.auth_token}"

        expect(response.status).to eq 200
        expect(req.reload.closed).not_to be_blank
        expect(req.reload.archived).not_to be_blank
      end
    end
  end
end
