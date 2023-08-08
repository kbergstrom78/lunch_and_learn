# frozen_string_literal: true

class ImagesService
  def self.get_images(country)
    response = conn.get("/search/photos?query=#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.unsplash.com') do |f|
      f.params['client_id'] = ENV['unsplash_access_key']
    end
  end
end
