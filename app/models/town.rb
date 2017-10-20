class Town < ActiveRecord::Base
  
  before_validation :load_position

  private
  def load_position
    if self.name.length > 0
      places = Nominatim.search(name).limit(1)
      self.lat = places.first.lat
      self.lon = places.first.lon
    end
  end
  
  public
  def load_weather
    ForecastIO.configure do |c|
      c.api_key = 'dce49a468ca99d06830eff50df3364eb'
    end
    ForecastIO.forecast(self.lat, self.lon) 
  end
end