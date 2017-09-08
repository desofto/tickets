require 'rails_helper'

describe API::V1::User, type: :api do
  let(:admin) { create(:admin) }

  describe 'GET /api/v1/clients' do
    it 'returns clients with pagination' do
      create_list(:client, 2)

      get "/api/v1/clients?auth_token=#{admin.auth_token}&per_page=1"

      expect(response.status).to eq 200
      expect(json['clients'].count).to eq 1
      expect(json['total']).to eq 2
    end
  end

  describe 'GET /api/v1/agents' do
    it 'returns agents with pagination' do
      create_list(:agent, 2)

      get "/api/v1/agents?auth_token=#{admin.auth_token}&per_page=1"

      expect(response.status).to eq 200
      expect(json['agents'].count).to eq 1
      expect(json['total']).to eq 2
    end
  end
end
