class Station
  attr_reader :name

  def initialize(info)
    @name = info[:station_name]
  end

end
