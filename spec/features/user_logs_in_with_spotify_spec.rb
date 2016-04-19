require 'rails_helper'

RSpec.feature "UserLogsInWithSpotify", type: :feature do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits the root and logs in with spotify credintials" do
      visit "/"
      click_on "login-button"

      expect(page).to have_content "Welcome Adam Hundley"
      expect(User.count).to eq 1
  end
end
