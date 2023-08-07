class AirQualitySerializer < ActiveModel::Serializer
  attributes :id, :type, :city, :attributes

  def id
    nil
  end

  def type
    'air_quality'
  end

  def attributes
    {
      aqi: object[:aqi],
      pm25_concentration: object[:pm25_concentration],
      co_concentration: object[:co_concentration]
    }
  end
end
