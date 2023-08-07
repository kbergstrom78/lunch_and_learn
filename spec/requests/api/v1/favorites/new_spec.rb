require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  describe "POST /api/v1/favorites" do
    let(:user) { create(:user) }

    let(:valid_attributes) do
      {
        api_key: user.api_key,
        country: "Thailand",
        recipe_link: "https://www.example.com",
        recipe_title: "Example Recipe"
      }
    end

    it "creates a favorite with a valid API key" do
      post "/api/v1/favorites", params: valid_attributes.to_json, headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Token token=\"#{user.api_key}\""
      }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['success']).to eq('Favorite added successfully')
    end

    it "returns an error with an invalid API key" do
      post "/api/v1/favorites", params: valid_attributes.merge(api_key: 'invalid').to_json, headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Token token=\"invalid\""
      }

      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)['error']).to eq('Invalid API key')
    end
  end
end