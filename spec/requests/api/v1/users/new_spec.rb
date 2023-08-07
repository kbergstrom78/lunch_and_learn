require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) {
        {
          name: "Odell",
          email: "goodboy@ruffruff.com",
          password: "treats4lyf",
          password_confirmation: "treats4lyf"
        }
      }

      it 'creates a new User' do
        expect {
          post "/api/v1/users", params: { user: valid_attributes }, as: :json
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        user = User.last
        expect(JSON.parse(response.body)['data']['attributes']['name']).to eq(user.name)
        expect(JSON.parse(response.body)['data']['attributes']['email']).to eq(user.email)
        expect(JSON.parse(response.body)['data']['attributes']['api_key']).to eq(user.api_key)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) {
        {
          name: "Odell",
          email: "goodboy@ruffruff.com",
          password: "treats4lyf",
          password_confirmation: "wrong_password"
        }
      }

      it 'does not create a new User' do
        expect {
          post "/api/v1/users", params: { user: invalid_attributes }, as: :json
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('error')
      end
    end

    context 'with duplicate email' do
      it 'returns an error message' do
        user_attributes = attributes_for(:user)
        post "/api/v1/users", params: { user: user_attributes }, as: :json
        post "/api/v1/users", params: { user: user_attributes }, as: :json

        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)['error']).to eq('Email has already been taken')
      end
    end
  end
end

