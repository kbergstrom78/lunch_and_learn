# frozen_string_literal: true

require 'rails_helper'

describe 'The Recipes API', type: :request do
  describe 'GET /api/v1/recipes/search' do
    let(:user) { create(:user) }
    it 'can find recipes based on chosen country', :vcr do
      chosen_country = 'italy'

      get "/api/v1/recipes?country=#{chosen_country}", headers: { 'Authorization' => "Token token=\"#{user.api_key}\"" }
      expect(response).to be_successful

      recipes = JSON.parse(response.body, symbolize_names: true)

      expect(recipes).to be_a(Hash)
      expect(recipes).to have_key(:data)
      expect(recipes[:data]).to be_an(Array)

      recipes[:data].each do |recipe|
        expect(recipe).to have_key(:id)
        expect(recipe[:id]).to eq(nil)

        expect(recipe).to have_key(:type)
        expect(recipe[:type]).to eq('recipe')

        expect(recipe).to have_key(:attributes)
        expect(recipe[:attributes]).to have_key(:title)
        expect(recipe[:attributes]).to have_key(:url)
        expect(recipe[:attributes]).to have_key(:country)
        expect(recipe[:attributes][:country]).to eq(chosen_country)
        expect(recipe[:attributes]).to have_key(:image)
        expect(recipe[:attributes].keys.size).to eq(4)
        expect(recipe[:attributes]).to_not have_key(:calories)
        expect(recipe[:attributes]).to_not have_key(:dietLabels)
      end
    end

    it 'can find recipes based on a random country', :vcr do
      VCR.use_cassette('The_Recipes_API/can_find_recipes_based_on_a_random_country', record: :new_episodes) do
        get '/api/v1/recipes', headers: { 'Authorization' => "Token token=\"#{user.api_key}\"" }

        expect(response).to be_successful

        recipes = JSON.parse(response.body, symbolize_names: true)

        expect(recipes).to be_a(Hash)
        expect(recipes).to have_key(:data)
        expect(recipes[:data]).to be_an(Array)

        expect(recipes[:data][0]).to have_key(:id)
        expect(recipes[:data][0][:id]).to eq(nil)

        expect(recipes[:data][0]).to have_key(:type)
        expect(recipes[:data][0][:type]).to eq('recipe')

        expect(recipes[:data][0]).to have_key(:attributes)
        expect(recipes[:data][0][:attributes]).to have_key(:title)
        expect(recipes[:data][0][:attributes]).to have_key(:url)
        expect(recipes[:data][0][:attributes]).to have_key(:country)
        expect(recipes[:data][0][:attributes]).to have_key(:image)
        expect(recipes[:data][0][:attributes].keys.size).to eq(4)
      end
    end

    it 'returns an empty array when no recipes match the chosen country', :vcr do
      country = 'vatican city'

      get "/api/v1/recipes?country=#{country}", headers: { 'Authorization' => "Token token=\"#{user.api_key}\"" }
      expect(response).to be_successful

      no_recipes = JSON.parse(response.body, symbolize_names: true)

      expect(no_recipes).to be_a(Hash)
      expect(no_recipes).to have_key(:data)
      expect(no_recipes[:data]).to be_an(Array)
      expect(no_recipes[:data]).to eq([])
    end

    it 'returns an empty array when an empty string is given as a parameter', :vcr do
      get '/api/v1/recipes?country=', headers: { 'Authorization' => "Token token=\"#{user.api_key}\"" }
      expect(response).to be_successful

      no_recipes = JSON.parse(response.body, symbolize_names: true)

      expect(no_recipes).to be_a(Hash)
      expect(no_recipes).to have_key(:data)
      expect(no_recipes[:data]).to be_an(Array)
      expect(no_recipes[:data]).to eq([])
    end
  end
end
