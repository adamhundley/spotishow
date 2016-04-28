require 'rails_helper'

RSpec.describe UserArtistCreator, type: :model do
  it "should be make all the artists" do
    VCR.use_cassette("user_artist_creator#make_artists") do
      user = User.create(name: "Adam", uid: "adamhundley", token: ENV["SPOTIFY_TOKEN"])

      objects = UserArtistCreator.make_artists(user)

      show = objects.first
      expect(objects.count).to eq 50
      expect(show.class).to eq UserShowCreator
      expect(show.artist.class).to eq Artist
      expect(show.artist.name).to eq "John Mayer"
    end
  end

  it "should be make a new artist" do
    VCR.use_cassette("user_artist_creator#new_artist") do
      user = User.create(name: "Adam", uid: "adamhundley", token: ENV["SPOTIFY_TOKEN"])

      object = UserArtistCreator.artist("Sting", user)

      expect(object.class).to eq UserShowCreator
      expect(object.artist.class).to eq Artist
      expect(object.artist.name).to eq "Sting"
      expect(object.artist.shows.first.title).to eq "Sting @ Pepsi Center in Denver, CO"
    end
  end
end
