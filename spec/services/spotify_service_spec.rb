require 'rails_helper'

describe SpotifyService do
  context "#top artists" do
    scenario "returns top artists" do
      VCR.use_cassette("spotify_service#top_artists") do
         user = User.create(token: "BQAatGFNcWu94Pl6tocmybhNVG_bOqTU2gVZLnANYtrhMGXQ7w5813RNn4rQGmCmmjzPR-lr6Dgx9bF8Axd4NVtwwwIE_8HidXlS0kPkOxnH_P6zyuydglcS-Qz92UJAapGoFwO6KMvRZO9YhE5roSL8")

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
