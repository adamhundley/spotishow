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

      user = User.find_by(uid: "adamhundley")
      huron = Artist.find_by(name: "Lord Huron")

      expect(user.artists.count).to eq 50
      expect(user.shows.count).to eq 11

      within("tr#artist-#{huron.id}") do
        click_on "untrack"
      end

      wait_for_ajax

      expect(user.artists.count).to eq 49
      expect(user.shows.count).to eq 10
      expect(page).to_not have_content "Lord Huron"
    end
  end
end
