require 'rails_helper'

RSpec.describe AqiService do
  it 'gets AQI data for a city', :vcr do
    city = 'Paris'
    response = AqiService.get_aqi(city)

    expect(response).to be_a(Hash)
    expect(response[:overall_aqi]).to be_a(Integer)
    expect(response[:"PM2.5"][:concentration]).to be_a(Float)
    expect(response[:CO][:concentration]).to be_a(Float)
  end
end