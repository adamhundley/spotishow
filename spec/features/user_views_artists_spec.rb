require 'rails_helper'

RSpec.feature "UserLogsInWithSpotify", type: :feature do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits the root and logs in with spotify credintials" do
    VCR.use_cassette("feature#top_artists") do
      visit "/"
      click_on "login-button"
      click_on "my artists"
      expect(current_path).to eq "/adamhundley/artists"
      expect(page).to have_content "John Mayer"
      expect(Artist.count).to eq 50
    end
  end
end
