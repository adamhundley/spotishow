require 'rails_helper'

describe SpotifyService do
  context "#top artists" do
    scenario "returns top artists" do
      VCR.use_cassette("spotify_service#top_artists") do
         user = User.create(token: "BQBX-jRP3gJsQgI9lBWyFcySebE7CcdK-A2Eu68ku8-L5iLJZpoScBQyk-y6DrIEj0cBBG_S1BmmrceLMKPM0V7wfUP-GZdALI0UgrZriJ_RE6TN1dykXEqtGHB2Vcg0_eR7PLeBhyFmSSasl0cToHLr")

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
