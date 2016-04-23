require 'rails_helper'

RSpec.feature "UserLogsInWithSpotify", type: :feature do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits the root and logs in with spotify credintials" do
    VCR.use_cassette("feature#top_artists") do
      send_location
      
      visit "/"
      click_on "login-button"
      click_on "my artists"
      expect(current_path).to eq "/adamhundley/artists"

      mayer = Artist.find_by(name: "John Mayer")
      rector = Artist.find_by(name:"Ben Rector")
      huron = Artist.find_by(name: "Lord Huron")

      within("tr#artist-#{mayer.id}") do
        expect(page).to have_content "John Mayer"
      end

      within("tr#artist-#{huron.id}") do
        expect(page).to have_content "Lord Huron"
      end

      within("tr#artist-#{rector.id}") do
        expect(page).to have_content "Ben Rector"
      end

      expect(page).to_not have_content "Rick Astley"
    end
  end
end
