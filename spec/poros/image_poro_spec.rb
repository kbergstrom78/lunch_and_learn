# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  describe '#initialize' do
    it 'creates an image from given attributes' do
      image_data = {
        alt_description: 'Beautiful Sunset',
        urls: {
          regular: 'https://example.com/sunset.jpg'
        }
      }

      image = Image.new(image_data)

      expect(image.alt_tag).to eq('Beautiful Sunset')
      expect(image.url).to eq('https://example.com/sunset.jpg')
    end
  end
end
