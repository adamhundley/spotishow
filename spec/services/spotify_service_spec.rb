require 'rails_helper'

describe SpotifyService do
  context "#top artists" do
    scenario "returns top artist" do
      VCR.use_cassette("spotify_service#top_artists") do
         user = User.create(token: "BQAatGFNcWu94Pl6tocmybhNVG_bOqTU2gVZLnANYtrhMGXQ7w5813RNn4rQGmCmmjzPR-lr6Dgx9bF8Axd4NVtwwwIE_8HidXlS0kPkOxnH_P6zyuydglcS-Qz92UJAapGoFwO6KMvRZO9YhE5roSL8")

        service = SpotifyService.new
        artists = service.top_artists(user)
        artist = artists.first
        expect(artist[:name]).to eq "John Mayer"
        # expect(user.artists.count).to eq 50
        # expect(user.artists.first.class).to eq Artist
      end
    end
  end
end
