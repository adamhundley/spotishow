require 'rails_helper'

RSpec.feature "UserLogsInWithSpotify", type: :feature do
  before(:each) do
    @user = User.create(uid: "adamhundley", latitude: 39.7392, longitude: -104.9903)
    @user.artists << Artist.create(name: "Lord Huron")
  end

  describe "User visits the root and logs in with spotify credintials and views their shows" do
    before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)  }

    scenario "User visits the root and logs in with spotify credintials and views their shows" do
      VCR.use_cassette("feature#shows") do
        visit "/"
        click_on "my shows"
        expect(current_path).to eq "/adamhundley/shows"
        expect(page).to have_content "Lord Huron @ Red Rocks"
      end
    end
  end
end
