class CountryService
  def self.conn
    Faraday.new("https://restcountries.com")
  end

  def self.all_countries
    response = conn.get("/v3.1/all")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_capital_city(country_name)
    response = conn.get("/v3/name/#{country_name}")
    JSON.parse(response.body, symbolize_names: true).first[:capital].first
  end
end