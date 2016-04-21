require 'rails_helper'

describe SpotifyService do
  context "#top artists" do
    scenario "returns top artists" do
      VCR.use_cassette("spotify_service#top_artists") do
         user = User.create(token: "BQBcb9gpiulwmu-H1aehBMsBDom7Gdlr395TdBzKF7Qk_Nz5IzNyKGDl-KBXsS-fnKCK3dtPUldfY8foijndGQ8UgRwby5ulflJdFg3VWp2aWmODp_Dwi9weS9eFEL5aokZMUOI1Xw6KEX7TdSuqjviU")

        service = SpotifyService.new
        artists = service.top_artists(user)
        artist = artists.first
        expect(artists.count).to eq 50
        expect(artist[:name]).to eq "John Mayer"
        expect(artist[:id]).to eq "0hEurMDQu99nJRq8pTxO14"
        expect(artist[:href]).to eq "https://api.spotify.com/v1/artists/0hEurMDQu99nJRq8pTxO14"
        expect(artist[:popularity]).to eq 82
        expect(artist.keys).to eq [:external_urls, :followers, :genres, :href,
                                   :id, :images, :name, :popularity, :type, :uri]
      end
    end
  end
end
