class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :spotify_id
      t.string :spotify_uri
      t.integer :spotify_popularity
      t.string :spotify_image_url
      t.string :bit_image_url
      t.string :website
      t.string :facebook_url
      t.string :facebook_tour_url

      t.timestamps null: false
    end
  end
end
