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
      UserArtistCreator.new(new_user)
    end
  end

  def update_token
    new_token = SpotifyService.new.request_new_token(self)[:access_token]
    update_attribute(:token, new_token)
  end
end
