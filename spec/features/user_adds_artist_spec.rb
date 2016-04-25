require 'rails_helper'

Selenium::WebDriver.for :chrome

RSpec.feature "UserAddsAnArtist", type: :feature, js: true do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits their artist dashboard and adds a new artist" do
    VCR.use_cassette("feature#add_artist") do

      visit "/"
      click_on "login-button"
      visit "/adamhundley/artists"

      user = User.find_by(uid: "adamhundley")

      expect(user.artists.count).to eq 50
      expect(user.shows.count).to eq 11

      # within("div#add-artist") do
      #   fill_in "name", with: "Sufjan Stevens"
      #   click_on "search"
      # end
      #
      # wait_for_ajax
      #
      # visit "/adamhundley/dashboard"
      #
      # expect(user.artists.count).to eq 51
      # expect(user.shows.count).to eq 12
      # expect(page).to have_content "Sufjan Stevens"
    end
  end
end
