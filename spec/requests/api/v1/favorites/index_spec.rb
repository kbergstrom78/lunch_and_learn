require 'rails_helper'

RSpec.describe "Api::V1::Favorites", type: :request do
  describe 'GET index' do
    before :each do
      @user1 = User.create!(name: 'kila', email: 'kila@puppy.com', password: 'test1',
                            api_key: '123456abcdef')
      @user2 = User.create!(name: 'Chaco', email: 'chaco@doggo.com', password: 'test2',
                            api_key: 'abc123def456')
      @user3 = User.create!(name: 'Bruno', email: 'bruno@beasty.com', password: 'test3',
                            api_key: 'a1b2c3d4e5f6')

      @favorite1 = Favorite.create!(user_id: @user1.id, country: 'vietnam',
                                    recipe_link: 'https://www.seriouseats.com/kenji_rulez.html',
                                    recipe_title: 'Garlic Noodles (a San Francisco Treat, not THE San Francisco Treat)')

      @favorite2 = Favorite.create!(user_id: @user1.id,country: 'egypt',
                                    recipe_link: 'http://www.thekitchn.com/why-is-the-e-missing.html',
                                    recipe_title: 'Recipe: Egyptian Tomato Soup')

      @favorite3 = Favorite.create!(user_id: @user2.id, country: 'thailand',
                                    recipe_link: 'https://www.tastingtable.com/fried-rice-is-delicious.html',
                                    recipe_title: 'Crab Fried Rice (Khaao Pad Bpu)')
    end

    it 'can get all favorites for a given user' do
      headers = {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'
                }

      get "/api/v1/favorites?api_key=#{@user1.api_key}", headers: headers

      expect(response).to be_successful
      favorites = JSON.parse(response.body,symbolize_names: true)

      expect(favorites).to be_a(Hash)
      expect(favorites).to have_key(:data)
      expect(favorites[:data]).to be_an(Array)
      expect(favorites[:data].size).to eq(2)

      favorites[:data].each do |favorite|
        expect(favorite).to have_key(:id)
        expect(favorite).to have_key(:type)
        expect(favorite[:type]).to eq("favorite")

        expect(favorite).to have_key(:attributes)
        expect(favorite[:attributes]).to have_key(:recipe_title)
        expect(favorite[:attributes]).to have_key(:recipe_link)
        expect(favorite[:attributes]).to have_key(:country)
        expect(favorite[:attributes]).to have_key(:created_at)
        expect(favorite[:attributes].keys.size).to eq(4)
      end
    end

    it 'returns an error when an invalid api_key is used to get all favorites' do
      headers = {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'
                }

      get "/api/v1/favorites?api_key=zyxwvu098765", headers: headers

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(error_data).to be_a(Hash)
      expect(error_data).to have_key(:error)
      expect(error_data[:error]).to eq('Invalid API key')
    end

    it 'returns an empty array if the user has no favorites' do
      headers = {
                    'Content-Type' => 'application/json',
                    'Accept' => 'application/json'
                }

      get "/api/v1/favorites?api_key=#{@user3.api_key}", headers: headers

      no_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(no_data).to be_a(Hash)
      expect(no_data).to have_key(:data)
      expect(no_data[:data]).to eq([])
    end
  end
end