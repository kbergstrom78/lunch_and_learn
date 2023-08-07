require 'rails_helper'

RSpec.describe Api::V1::AirQualityController, type: :request do
  describe 'GET #show', :vcr do
    [
      { country_name: 'France', city: 'Paris', aqi: 84, pm25: 2.47, co: 220.3 },
      { country_name: 'Nigeria', city: 'Abuja', aqi: 25, pm25: 4.21, co: 433.92 },
      { country_name: 'Cuba', city: 'Havana', aqi: 69, pm25: 6.57, co: 240.33 }
    ].each do |test_case|

      context "when country is #{test_case[:country_name]}" do
        it 'returns the air quality data for the specified country' do
          get "/api/v1/air_quality", params: { country: test_case[:country_name] }

          expected_response = {
            "data": {
              "id": nil,
              "type": "air_quality",
              "city": test_case[:city],
              "attributes": {
                "aqi": test_case[:aqi],
                "pm25_concentration": test_case[:pm25],
                "co_concentration": test_case[:co]
              }
            }
          }.to_json

          expect(response.body).to eq(expected_response)
        end
      end
    end
  end
end
