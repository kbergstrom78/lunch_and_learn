require 'rails_helper'

RSpec.describe AqiFacade do
  it 'gets air quality data for a country', :vcr do
    country_name = 'France'
    facade = AqiFacade.new(country_name)
    response = facade.air_quality_data

    expect(response).to be_a(Hash)

    expect(response[:data]).to have_key(:id)
    expect(response[:data][:id]).to be_nil

    expect(response[:data]).to have_key(:type)
    expect(response[:data][:type]).to eq("air_quality")

    expect(response[:data]).to have_key(:city)
    expect(response[:data][:city]).to be_a(String)

    expect(response[:data]).to have_key(:attributes)
    expect(response[:data][:attributes]).to have_key(:aqi)
    expect(response[:data][:attributes][:aqi]).to be_a(Integer)

    expect(response[:data][:attributes]).to have_key(:pm25_concentration)
    expect(response[:data][:attributes][:pm25_concentration]).to be_a(Float)

    expect(response[:data][:attributes]).to have_key(:co_concentration)
    expect(response[:data][:attributes][:co_concentration]).to be_a(Float)
  end
end