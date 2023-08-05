class RecipesService
  def self.get_recipes(country)
    response = conn.get("/api/recipes/v2?type=any&q=#{country}")
    JSON.parse(response.body,symbolize_names: true)
  end

  def self.conn
    Faraday.new("https://api.edamam.com") do |f|
      f.params["app_id"] = ENV["edamam_id"]
      f.params["app_key"] = ENV["edamam_key"]
    end
  end
end