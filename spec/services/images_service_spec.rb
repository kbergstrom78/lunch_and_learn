require 'rails_helper'

RSpec.describe ImagesService do
  it '.all_countries', :vcr do
    images = ImagesService.get_images('morocco')

    expect(images).to be_a Hash
    expect(images).to have_key :results

    images[:results].each do |image|
      expect(image).to have_key :alt_description
      expect(image).to have_key :urls
      expect(image[:urls]).to have_key :regular
    end
  end
end