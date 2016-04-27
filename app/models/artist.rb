class Artist < ActiveRecord::Base
  has_many :user_artists, dependent: :destroy
  has_many :users, through: :user_artists
  has_many :shows

  validates :name, presence: true, uniqueness: true
  validates :spotify_id, presence: true, uniqueness: true
  validates :spotify_uri, presence: true
  validates :spotify_popularity, presence: true

  # default_scope { order('created_at DESC') }
end
