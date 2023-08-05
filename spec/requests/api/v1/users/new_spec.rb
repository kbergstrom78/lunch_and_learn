require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { attributes_for(:user) }

      it 'creates a new User' do
        expect {
          post "/api/v1/users", params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user API key' do
        post "/api/v1/users", params: { user: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('api_key')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { attributes_for(:user, password_confirmation: 'wrong_password') }

      it 'does not create a new User' do
        expect {
          post "/api/v1/users", params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end

      it 'renders a JSON response with errors' do
        post "/api/v1/users", params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('error')
      end
    end

    context 'with duplicate email' do
      it 'returns an error message' do
        user_attributes = attributes_for(:user)
        post api_v1_users_path, params: { user: user_attributes }
        post api_v1_users_path, params: { user: user_attributes }

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to eq('Email has already been taken')
      end
    end

    context 'with mismatched passwords' do
      it 'returns an error message' do
        user_attributes = attributes_for(:user, password: 'password1', password_confirmation: 'password2')
        post api_v1_users_path, params: { user: user_attributes }

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to eq("Password confirmation doesn't match Password")
      end
    end
  end
end

