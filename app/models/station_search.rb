class StationSearch

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def stations
    fuel_stations do |station_info|
      Station.new(station_info)
    end
  end

  def fuel_stations
    get_json("/api/alt-fuel-stations/v1/nearest.json?limit=10&location=#{@zip_code}")[:fuel_stations]
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names:true)
  end

  def conn
    Faraday.new("https://developer.nrel.gov/") do |faraday|
      faraday.headers["X-Api-Key"] = "#{ENV["nrel_api_key"]}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
