require 'rails_helper'

RSpec.describe Api::V1::AirQualityController, type: :request do
  describe 'GET #search', :vcr do
    [
      { country_name: 'France', city: 'Paris', aqi: 66, pm25: 3.13, co: 226.97 },
      { country_name: 'Nigeria', city: 'Abuja', aqi: 25, pm25: 5.23, co: 467.3 },
      { country_name: 'Cuba', city: 'Havana', aqi: 110, pm25: 6.88, co: 250.34 }
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
