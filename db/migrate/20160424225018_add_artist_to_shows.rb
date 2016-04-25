class AddArtistToShows < ActiveRecord::Migration
  def change
    add_reference :shows, :artist, index: true, foreign_key: true
  end
end
