class AirQualitySerializer
  def initialize(air_quality_data)
    @air_quality_data = air_quality_data
  end

  def as_json(*)
    {
      data: {
        id: nil,
        type: 'air_quality',
        city: @air_quality_data[:city],
        attributes: {
          aqi: @air_quality_data[:aqi],
          pm25_concentration: @air_quality_data[:pm25_concentration],
          co_concentration: @air_quality_data[:co_concentration]
        }
      }
    }
  end
end

