# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoFacade, type: :model do
  describe '.get_video' do
    it 'returns a video for a given country', :vcr do
      country = 'USA'
      video = VideoFacade.get_video(country)

      expect(video).to be_a(Video)
      expect(video.title).to be_a(String)
    end

    it 'returns nil if no videos are found', :vcr do
      country = 'KimsCountryofGreatness'
      video = VideoFacade.get_video(country)

      expect(video).to eq(nil)
    end
  end
end
