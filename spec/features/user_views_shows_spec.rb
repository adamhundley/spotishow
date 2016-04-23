require 'rails_helper'

RSpec.feature "UserLogsInWithSpotify", type: :feature do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits the root and logs in with spotify credintials and views their shows" do
    VCR.use_cassette("feature#shows") do

      send_location

      visit "/"

      click_on "login-button"

      click_on "my shows"

      expect(current_path).to eq "/adamhundley/shows"

      expect(page).to have_content "Lord Huron @ Red Rocks"
      expect(page).to have_content "Ryan Adams @ Red Rocks"
      expect(page).to have_content "The Lone Bellow @ Rocky Mountain Folks Festival"
      expect(page).to_not have_content "Sting @ The Greek"

      expect(User.first.shows.count).to eq 11
    end
  end
end
