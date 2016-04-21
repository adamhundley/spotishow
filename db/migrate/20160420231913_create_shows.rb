class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.integer :bit_id
      t.datetime :datetime
      t.string :formatted_datetime
      t.string :formatted_location
      t.string :ticket_url
      t.string :facebook_rsvp_url
      t.string :venue_name
      t.string :artist_name
      t.float :venue_latitude
      t.float :venue_longitude

      t.timestamps null: false
    end
  end
end
