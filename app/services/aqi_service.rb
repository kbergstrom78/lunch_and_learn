class AqiService
  def self.conn
    Faraday.new(url: "https://api.api-ninjas.com") do |f|
      f.headers['x-api-key'] = ENV['aqi_key']
    end
  end

  def self.get_aqi(city)
    response = conn.get("/v1/airquality?city=#{city}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
