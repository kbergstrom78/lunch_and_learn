# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Favorites', type: :request do
  describe 'DELETE /api/v1/favorites/:id' do
    let(:user) { create(:user) }
    let!(:favorite) { create(:favorite, user_id: user.id) }

    it 'deletes a favorite with a valid API key' do
      delete "/api/v1/favorites/#{favorite.id}?api_key=#{user.api_key}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['success']).to eq('Favorite deleted successfully')
    end

    it 'returns an error when the favorite is not found' do
      delete "/api/v1/favorites/9999?api_key=#{user.api_key}"

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Favorite not found')
    end
  end
end
