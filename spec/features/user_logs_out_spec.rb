require 'rails_helper'

RSpec.feature "UserLogsOut", type: :feature do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits the root and logs in with spotify credintials and then logs out" do
    visit "/"
    click_on "login-button"

    expect(page).to have_link "logout"

    click_on "logout"

    expect(page).to have_content "Welcome to Spotishow"
  end
end
