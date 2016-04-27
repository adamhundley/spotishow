require 'rails_helper'


RSpec.feature "UserLogsInWithSpotify", type: :feature do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits the root and logs in with spotify credintials and views dashboard" do
    VCR.use_cassette("spotify#login") do
      send_location

      visit "/"
      click_on "login-button-1"

      expect(User.count).to eq 1
      expect(current_path).to eq "/adamhundley/dashboard"

      within("div#my-location") do
        expect(page).to have_content "location"
      end

      within("div#my-artists") do
        expect(page).to have_content "artists"
        expect(User.first.artists.count).to eq 50
      end

      within("div#my-shows") do
        expect(page).to have_content "shows"
        expect(User.first.shows.count).to eq 11
      end

      visit '/'

      expect(current_path).to eq "/adamhundley/dashboard"
      expect(page).to_not have_content "login"
    end
  end
end
