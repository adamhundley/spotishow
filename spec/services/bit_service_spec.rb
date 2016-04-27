require 'rails_helper'

describe BitService do
  context "#show" do
    scenario "return a show" do
      VCR.use_cassette("bit_service#show") do
        service = BitService.new
        artist = "Lord Huron"
        user = User.create(latitude: 39.7392, longitude: -104.9903)
        show = service.show(artist, user).first
        expect(show.keys).to eq [:id, :title, :datetime,
                                        :formatted_datetime, :formatted_location,
                                        :ticket_url, :ticket_type,
                                        :ticket_status, :on_sale_datetime,
                                        :facebook_rsvp_url, :description,
                                        :artists, :venue]
        expect(show[:title]).to eq "Lord Huron @ Red Rocks Amphitheatre in Morrison, CO"
      end
    end
  end
end
