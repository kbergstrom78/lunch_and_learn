# frozen_string_literal: true

RSpec.describe Api::V1::UsersController, type: :controller do
  # ...

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        {
          name: 'John Doe',
          email: 'john@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it 'creates a new User' do
        expect do
          post :create, params: valid_attributes
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)

        user = User.last
        expect(JSON.parse(response.body)['data']['attributes']['name']).to eq(user.name)
        expect(JSON.parse(response.body)['data']['attributes']['email']).to eq(user.email)
        expect(JSON.parse(response.body)['data']['attributes']['api_key']).to eq(user.api_key)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          name: 'John Doe',
          email: 'john@example.com',
          password: 'password',
          password_confirmation: 'wrong_password'
        }
      end

      it 'does not create a new User' do
        expect do
          post :create, params: invalid_attributes
        end.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Password confirmation doesn\'t match Password')
      end
    end

    context 'with duplicate email' do
      it 'returns an error message' do
        user_attributes = attributes_for(:user)
        post :create, params: user_attributes
        post :create, params: user_attributes

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Email has already been taken')
      end
    end
  end
end
