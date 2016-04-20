class Artist < ActiveRecord::Base
  has_many :user_artists
  has_many :users, through: :user_artists
  
  # attr_reader :name, :spotify_id, :spotify_uri, :spotify_popularity,
  #             :spotify_image_url, :bit_image_url, :website,
  #             :facebook_url, :facebook_tour_url

  # def initialize(artist_data)
  #   @name = artist_data[:name]
  #   @spotify_id = artist_data[:id]
  #   @spotify_uri = artist_data[:uri]
  #   @spotify_popularity = artist_data[:popularity]
  #   if artist_data[:images] != []
  #     @spotify_image_url = artist_data[:images].first[:url]
  #   end
  # end

  # def self.build_objects(artists)
  #   artists.map do |artist|
  #     Artist.new(artist)
  #   end
  # end
end
