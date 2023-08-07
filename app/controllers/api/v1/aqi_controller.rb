class Api::V1::AqiController < ApplicationController
  def show
    country_name = params[:country]
    aqi = AqiFacade.new(country_name)

    render json: aqi.air_quality_data
  end
end