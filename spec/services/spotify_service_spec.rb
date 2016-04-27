require 'rails_helper'

describe SpotifyService do
  context "#top artists" do
    scenario "returns top artists" do
      VCR.use_cassette("spotify_service#top_artists") do
         user = User.create(token: "BQBP14wozosOfEc8y9lMJ56dAGa1dmKKV-HUk_pHGPoOCwJ4DwbbHT_OFz0fjJ2CBToBV-AHIvIYOC9K5WodbDCmnn0nq9uCD2RXIsO2OaDokJXHg1Ns9i_CxrPtEgsp7h-YrBj51A_63J9wCT5_EKkHX0piEW8pcD8GErH6uAx_X99Bnw06TcNCldOaI-NExi0_Qa-c2syeDz8suyP24-LUVn3gdbvgoGgY88M5o8iq1ZdGPBlWznxRrmiE0hiYTZJ7TrpT6-cjK4OtfWhhlFkbu4G75VYkU7qwQGbD_jRU_jHBHyYyb-fU", uid: "adamhundley")

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

  context "#one artist" do
    scenario "returns an artist" do
      VCR.use_cassette("spotify_service#artist") do
         user = User.create(token: "BQCin8-2OzmDKsQSAyizBUFo0OLXoF9OIXwwIBNejI8MrBn-GwzPwdEpc-AFL1tbNBDpuDa8U8e-YS50g4pIfyS8H-iELcYrwf5XxyW1UJhN66KIymLk4MVcFcUJ4SmevnpMKOuZVYsySqBrLVXyRPX92ouC4Fc051pRk0l-83VDPs14jCN65QNCXxvZxGFj2VG1QZo1UMZjhd4L3Ct5PtBUtbz_n4f7qeQfUBt_DsTP3wH4eQlajdZhyjunht5CMl5r3XQkGJlL9uQ_N3zcrn8FBsnWbK2YtnElKnibYfGaAqKvKYrmEozO", uid: "adamhundley")
         artist = "Sting"

        service = SpotifyService.new
        artist = service.artist(artist, user)
        expect(artist[:name]).to eq "Sting"
        expect(artist[:id]).to eq "0Ty63ceoRnnJKVEYP0VQpk"
        expect(artist[:href]).to eq "https://api.spotify.com/v1/artists/0Ty63ceoRnnJKVEYP0VQpk"
        expect(artist[:popularity]).to eq 69
        expect(artist.keys).to eq [:external_urls, :followers,
                                  :genres, :href,
                                  :id, :images, :name, :popularity,
                                  :type, :uri]
      end
    end
  end
end
