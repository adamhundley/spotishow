require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe Artist do
    it { should have_many :users }
    it { should have_many :user_artists }
    it { should have_many :shows }
    it { should validate_presence_of :name }
    it { should validate_presence_of :spotify_id }
    it { should validate_presence_of :spotify_uri }
    it { should validate_presence_of :spotify_popularity }
  end

  it "should be valid" do
    artist = Artist.create( name: "test",
                            spotify_id: 123,
                            spotify_uri: 123,
                            spotify_popularity: 123,
                            spotify_image_url: "www.text.com")

    expect(artist).to be_instance_of Artist
    expect(artist).to be_valid
  end
end
