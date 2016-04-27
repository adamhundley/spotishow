require 'rails_helper'

RSpec.describe Show, type: :model do
  describe Show do
    it { should belong_to :artist }
    it { should have_many :user_shows }
    it { should have_many :users }
    it { should validate_presence_of :bit_id }
    it { should validate_presence_of :datetime }
    it { should validate_presence_of :formatted_datetime }
    it { should validate_presence_of :formatted_location }
  end

  it "should be valid" do
    artist = Show.create( bit_id: 1234,
                          datetime: "20160515".to_datetime,
                          formatted_datetime: "Sunday May 25, 2016",
                          formatted_location: "Silly Place",
                          ticket_url: "www.ticket.com",
                          venue_name: "Silly Place",
                          artist_name: "Silly Name",
                          venue_latitude: "40.123451",
                          venue_longitude: "-123.123",
                          title: "Silly Title")

    expect(artist).to be_instance_of Show
    expect(artist).to be_valid
  end
end
