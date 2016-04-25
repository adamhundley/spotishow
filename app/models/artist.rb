class Artist < ActiveRecord::Base
  has_many :user_artists
  has_many :users, through: :user_artists
  has_many :shows

  # default_scope { order('created_at DESC') }
end
