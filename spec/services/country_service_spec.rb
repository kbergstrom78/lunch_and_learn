require 'rails_helper'

RSpec.describe CountryService do
  it '.all_countries', :vcr do
    countries = CountryService.all_countries

    expect(countries).to be_an Array

    countries.each do |country|
      expect(country).to have_key :name
      expect(country[:name]).to have_key :common
    end
  end

  it 'gets capital city', :vcr do
    country_name = "France"
    capital_city = CountryService.get_capital_city(country_name)

    expect(capital_city).to be_a(String)
    expect(capital_city).to eq("Paris")
  end
end