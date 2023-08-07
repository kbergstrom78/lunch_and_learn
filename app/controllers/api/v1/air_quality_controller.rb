class Api::V1::AirQualityController < ApplicationController
  def search
    country_name = params[:country]
    aqi = AqiFacade.new(country_name)

    render json: aqi.air_quality_data, serializer: ::AirQualitySerializer
  end
end