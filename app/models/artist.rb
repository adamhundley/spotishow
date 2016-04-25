class Artist < ActiveRecord::Base
  has_many :user_artists
  has_many :users, through: :user_artists
  has_many :shows
end
