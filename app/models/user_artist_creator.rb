class UserArtistCreator
  def initialize(user)
    artists = spotify_service.top_artists(user)
    make_artists(artists, user)
  end

  def spotify_service
    SpotifyService.new
  end

  def make_artists(artists, user)
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
    end
  end
end
