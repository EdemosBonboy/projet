class Town < ActiveRecord::Base
  
  #Validations
  validates :lat, :lon, presence: true
  
  before_validation :load_position

  private
  def load_position
    place = Nominatim.search(name).limit(1).first
    if place
      self.lat = place.lat
      self.lon = place.lon
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