require 'rails_helper'

Selenium::WebDriver.for :chrome

RSpec.feature "UserAddsAnArtist", type: :feature, js: true do
  before(:each) do
    stub_omniauth
  end

  scenario "User visits their artist dashboard and adds a new artist then untracks one then views a tour" do
    VCR.use_cassette("feature#add_artist_untrack_and_view_tour") do

      visit "/"
      click_on "login-button-1"
      visit "/adamhundley/artists"

      user = User.find_by(uid: "adamhundley")

      expect(user.artists.count).to eq 50
      expect(user.shows.count).to eq 11

      within("div#add-artist") do
        fill_in "name", with: "Sufjan Stevens"
        click_on "search"
      end

      wait_for_ajax

      visit "/adamhundley/dashboard"

      expect(user.artists.count).to eq 51
      expect(user.shows.count).to eq 12

      visit "/adamhundley/artists"

      expect(page).to have_content "Sufjan Stevens"

      huron = Artist.find_by(name: "Lord Huron")

      within("tr#artist-#{huron.id}") do
        click_on "untrack"
      end

      wait_for_ajax

      expect(user.artists.count).to eq 50
      expect(user.shows.count).to eq 11
      expect(page).to_not have_content "Lord Huron"

      mayer = Artist.find_by(name: "John Mayer")

      within("tr#artist-#{mayer.id}") do
        click_on "artist-tour-#{mayer.id}"
      end

      wait_for_ajax

      expect(page).to have_content "The Fillmore"
      expect(page).to have_content "Alpine Valley Music Theatre"
      expect(page).to_not have_content "Red Rocks"
    end
  end
end
