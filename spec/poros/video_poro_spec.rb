# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '#initialize' do
    it 'creates a video from given attributes' do
      video_data = {
        snippet: {
          title: 'Super Awesome Video'
        },
        id: {
          videoId: 12_345
        }
      }

      video = Video.new(video_data)

      expect(video.title).to eq('Super Awesome Video')
      expect(video.youtube_id).to eq(12_345)
    end
  end
end
