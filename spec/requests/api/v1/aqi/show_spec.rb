require 'rails_helper'

RSpec.describe Api::V1::AqiController, type: :request do
  describe 'GET #show', :vcr do
    let(:country_name) { 'France' }

    it 'returns the air quality data for the specified country' do
      get "/api/v1/aqi/#{country_name}"
      require 'pry'; binding.pry
      expected_response = {
        "data": {
          "id": nil,
          "type": "air_quality",
          "city": "Paris",
          "attributes": {
            "aqi": 84,
            "pm25_concentration": 2.95,
            "co_concentration": 216.96
          }
        }
      }.to_json

      expect(response.body).to eq(expected_response)
    end
  end
end