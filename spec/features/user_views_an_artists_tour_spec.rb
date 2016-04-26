require 'rails_helper'

Selenium::WebDriver.for :chrome

RSpec.feature "UserViewsAnArtistShows", type: :feature, js: true do
  before(:each) do
    stub_omniauth
  end

  scenario "User views a specific artists tour" do
    VCR.use_cassette("feature#artist_shows") do

      visit "/"
      click_on "login-button"
      visit "/adamhundley/artists"

      mayer = Artist.find_by(name: "John Mayer")

      within("tr#artist-#{mayer.id}") do
        click_on "artist-tour-#{mayer.id}"
      end

      wait_for_ajax

      within("div#artist-#{mayer.id}-modal") do
        expect(page).to have_content "The Fillmore"
        expect(page).to have_content "Alpine Valley Music Theatre"
        expect(page).to_not have_content "Red Rocks"
      end
    end
  end
end
