class StationSearch

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def stations
    get_json("/api/alt-fuel-stations/v1/nearest.json?limit=10&location=#{@zip_code}") do |station_info|
      Station.new()
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names:true)
  end

  def conn
    Faraday.new(:url => "https://developer.nrel.gov/") do |faraday|
      faraday.headers["X-Api-Key"] = "#{ENV["nrel_api_key"]}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
