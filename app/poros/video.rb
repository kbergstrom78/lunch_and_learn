# frozen_string_literal: true

class Video
  attr_reader :title,
              :youtube_id

  def initialize(data)
    @title = data[:snippet][:title]
    @youtube_id = data[:id][:videoId]
  end
end
