class UserArtistCreator
  def self.make_artists(user)
    artists = spotify_service.top_artists(user)
    new_method(artists, user)
  end

  def self.spotify_service
    SpotifyService.new
  end

  def self.artist(artist, user)
    artist_data = spotify_service.artist(artist, user)
    make_artist(artist_data, user)
  end

  def self.make_artist(artist, user)
    new_artist = Artist.find_or_create_by(
                  name: artist[:name],
                  spotify_id: artist[:id],
                  spotify_uri: artist[:uri],
                  spotify_popularity: artist[:popularity],
                  )
    if artist[:images] != []
      new_artist.update(spotify_image_url: artist[:images].first[:url])
    end
    user.artists << new_artist
    UserShowCreator.new(new_artist, user)
  end

  def self.new_method(artists, user)
    artists.map do |artist|
      new_artist = Artist.find_or_create_by(
                    name: artist[:name],
                    spotify_id: artist[:id],
                    spotify_uri: artist[:uri],
                    spotify_popularity: artist[:popularity],
                    )
      if artist[:images] != []
        new_artist.update(spotify_image_url: artist[:images].first[:url])
      end
      user.artists << new_artist
      UserShowCreator.new(new_artist, user)
    end
  end
end
