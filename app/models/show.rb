class Show < ActiveRecord::Base
  belongs_to :artist
  has_many :user_shows, dependent: :destroy
  has_many :users, through: :user_shows

  validates :bit_id, presence: true
  validates :datetime, presence: true
  validates :formatted_datetime, presence: true
  validates :formatted_location, presence: true

  default_scope { order('datetime ASC') }
end
