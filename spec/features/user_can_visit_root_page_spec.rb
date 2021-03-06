require 'rails_helper'

feature "User can visit root page" do
  scenario "and view navbar contents" do
    visit "/"
    within(".navbar") do
      expect(page).to have_content("AltFuelFinder")
      expect(page).to have_selector("input[value='Search by zip...']")
    end
  end
  scenario "and fill in zip code in search form and hit Locate" do
    visit root_path

    fill_in :zip_code, with: '80203'
    click_on "Locate"

    expect(current_path).to eq(search_path)
    expect(page).to have_content("10 Nearest Stations")

    conn = Faraday.new("https://developer.nrel.gov") do |faraday|
             faraday.headers["X-Api-Key"] = "#{ENV["nrel_api_key"]}"
             faraday.adapter Faraday.default_adapter
           end

    call = JSON.parse(conn.get("/api/alt-fuel-stations/v1/nearest.json?limit=10&location=80203").body, symbolize_names: true)

    station = Station.new(call[:fuel_stations].first)

    within(".station") do
      expect(page).to have_css(".name")
      expect(page).to have_content(station.name)
      expect(page).to have_css(".address")
      expect(page).to have_css(".fuel_type")
      expect(page).to have_css(".distance")
      expect(page).to have_css(".access_time")
    end
  end
end
