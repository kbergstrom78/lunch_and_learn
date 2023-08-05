require 'rails_helper'

RSpec.describe VideosService do
  let(:response_body) { File.open('./spec/fixtures/sample_json/laos_video_search.json') }

  it '.get_videos', :vcr do
    videos = VideosService.get_videos('morrocco')

    expect(videos).to be_a Hash
    expect(videos).to have_key :items

    videos[:items].each do |video|
      expect(video).to have_key :snippet
      expect(video[:snippet]).to have_key :title
      expect(video).to have_key :id
      expect(video[:id]).to have_key :videoId
    end
  end
end