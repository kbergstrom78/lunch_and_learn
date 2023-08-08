# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LearningResources', type: :request do
  describe 'GET #search', :vcr do
    let(:user) { create(:user) } # Define a user variable to use in the test cases

    context 'when videos and images are found' do
      let(:country) { 'USA' }

      before :each do
        get "/api/v1/learning_resources?country=#{country}",
            headers: { 'Authorization' => "Token token=\"#{user.api_key}\"" }
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns the correct data structure' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['data']).to include(
          'id' => nil,
          'type' => 'learning_resource',
          'attributes' => hash_including(
            'country' => country,
            'video' => hash_including('title' => 'A Super Quick History of Saudi Arabia',
                                      'youtube_id' => 'g6de09dl2wk'),
            'images' => array_including(hash_including(
                                          'alt_tag' => 'Statue of Liberty, New York under white and blue cloudy skies', 'url' => anything
                                        ))
          )
        )
      end
    end

    context 'when no videos or images are found' do
      let(:country) { 'GrilledCheezistan' }

      before do
        get "/api/v1/learning_resources?country=#{country}",
            headers: { 'Authorization' => "Token token=\"#{user.api_key}\"" }
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns empty objects for video and images' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['data']['attributes']['video']).to eq({})
        expect(parsed_body['data']['attributes']['images']).to eq([])
      end
    end
  end
end
