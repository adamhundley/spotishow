require 'rails_helper'

describe SpotifyService do
  context "#top artists" do
    scenario "returns top artist" do
      VCR.use_cassette("spotify_service#top_artists") do
         user = User.create(token: "BQDpWSTIQYOfEsCohji5TeULJF3wQtSbR7WiPpZADYiQ1eIKRhL24mozLjeHUZKYou-t21R9w-VXRrO7sFng2m-41Sddpkcr9oylk2zbqE6mEbD3mme9Z-drT7v5xVcKBCV0cROQ2nUWguRyvcXF7HKh")

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
