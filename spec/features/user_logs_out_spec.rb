require 'rails_helper'

RSpec.feature "UserLogsOut", type: :feature do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits the root and logs in with spotify credintials and then logs out" do
    VCR.use_cassette("spotify#logout") do
      send_location

      visit "/"

      click_on "login-button"

      expect(page).to have_link "logout"

      click_on "logout"

      expect(page).to have_content "Sad to see you go Adam Hundley. Come back again soon!"
    end
  end
end
