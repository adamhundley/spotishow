class User < ActiveRecord::Base
  validates :uid, uniqueness: true
  has_many :user_artists
  has_many :artists, through: :user_artists

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid           = auth_info.uid
      new_user.name          = auth_info[:info][:name]
      new_user.nickname      = auth_info[:info][:nickname]
      new_user.email         = auth_info[:info][:email]
      new_user.spotify       = auth_info[:info][:urls][:spotify]
      new_user.image         = auth_info[:info][:image]
      new_user.token         = auth_info[:credentials][:token]
      new_user.url           = auth_info[:extra][:raw_info][:href]
      new_user.refresh_token = auth_info[:credentials][:refresh_token]
      new_user.token_expire  = auth_info[:credentials][:expires_at]
      make_artists(new_user)
    end
  end

  def self.make_artists(new_user)
    artists = spotify_service.top_artists(new_user)
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
      new_user.artists << new_artist
    end
  end

  def self.spotify_service
    SpotifyService.new
  end

  def update_token
    new_token = SpotifyService.new.request_new_token(self)[:access_token]
    update_attribute(:token, new_token)
  end
end
