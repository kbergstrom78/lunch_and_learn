class AqiFacade
  def initialize(country_name)
    @country_name = country_name
  end

  def air_quality_data
    capital_city = CountryService.get_capital_city(@country_name)
    air_quality = AqiService.get_aqi(capital_city)
    {
      "data": {
        "id": nil,
        "type": "air_quality",
        "city": capital_city,
        "attributes": {
          "aqi": air_quality[:overall_aqi],
          "pm25_concentration": air_quality[:"PM2.5"][:concentration], # Updated to match response structure
          "co_concentration": air_quality[:CO][:concentration] # Updated to match response structure
        }
      }
    }
  end
end