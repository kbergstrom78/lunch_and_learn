# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with valid credentials' do
      it 'returns user details and api key' do
        post '/api/v1/sessions', params: { email: user.email, password: user.password }.to_json,
                                 headers: { 'Content-Type': 'application/json' }

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)

        expect(json_response['data']['attributes']['name']).to eq(user.name)
        expect(json_response['data']['attributes']['email']).to eq(user.email)
        expect(json_response['data']['attributes']['api_key']).to eq(user.api_key)
      end
    end

    context 'with invalid credentials' do
      it 'returns an error message' do
        post '/api/v1/sessions', params: { email: user.email, password: 'wrong_password' }.to_json,
                                 headers: { 'Content-Type': 'application/json' }

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('Invalid credentials')
      end
    end
  end
end
