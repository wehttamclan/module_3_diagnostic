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

    fill_in :q, with: '80203'
    click_on "Locate"
  end
end
