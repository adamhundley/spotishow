require 'rails_helper'

describe SpotifyService do
  context "#top artists" do
    scenario "returns top artists" do
      VCR.use_cassette("spotify_service#top_artists") do
         user = User.create(token: "BQA709QL6aQKKsArnnmNUsNujbk_1VB0a_vsQnivIrEag0J-Kl5KAOkUkQMZTZZiloHVc9EWdsy3Tp0RImGjEXNjGSonToY_i-EfrrlJbAgdwFgd2zZLcZM7tTCSXE52PW2RMn4CgiK7lkBNxPWQuFFy")

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
