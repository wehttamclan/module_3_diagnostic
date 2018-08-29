class Station
  attr_reader :name, :fuel_type, :address, :distance, :access_time

  def initialize(info)
    @name = info[:station_name]
    @address = info[:street_address]
    @fuel_type = info[:fuel_type_code]
    @distance = info[:distance]
    @access_time = info[:access_days_time]
  end

end
