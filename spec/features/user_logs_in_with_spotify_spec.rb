require 'rails_helper'

RSpec.feature "UserLogsInWithSpotify", type: :feature do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits the root and logs in with spotify credintials" do
      visit "/"
      click_on "login-button"

      expect(page).to have_content "Welcome to Spotishow, Adam Hundley!"
      expect(User.count).to eq 1
      expect(current_path).to eq "/adamhundley/dashboard"
      expect(page).to have_content "Current Location:"
      expect(page).to have_content "Tracked Artist:"
      expect(page).to have_content "Upcoming Shows:"
  end
end
