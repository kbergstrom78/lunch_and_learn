class Api::V1::LearningResourcesController < ApplicationController
  def search
    country = params[:country]
    video = VideoFacade.get_video(country)
    images = ImagesFacade.get_images(country)

    if video.nil? || images.nil?
      render json: LearningResourcesSerializer.no_results_found(country)
    else
      render json: LearningResourcesSerializer.serialize_resources(country, video, images)
    end
  end
end