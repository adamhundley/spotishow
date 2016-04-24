require 'rails_helper'

Selenium::WebDriver.for :chrome

RSpec.feature "UserUntracksAnArtist", type: :feature, js: true do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits their artist dashboard and untracks and artist" do
    VCR.use_cassette("feature#untrack_artist") do

      visit "/"
      click_on "login-button"
      visit "/adamhundley/artists"

      user = User.find(1)
      mayer = Artist.find_by(name: "John Mayer")

      expect(user.artists.count).to eq 50

      within("tr#artist-#{mayer.id}") do
        click_on "untrack"
      end

      wait_for_ajax

      expect(user.artists.count).to eq 49
      expect(page).to_not have_content "John Mayer"
    end
  end
end
