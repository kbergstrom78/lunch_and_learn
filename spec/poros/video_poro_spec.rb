require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '#initialize' do
    it 'creates a video from given attributes' do
      video_data = {
        snippet: {
          title: "Super Awesome Video",
        },
        id: {
          videoId: 12345
        }
      }

      video = Video.new(video_data)
      
      expect(video.title).to eq("Super Awesome Video")
      expect(video.youtube_id).to eq(12345)
    end
  end
end
