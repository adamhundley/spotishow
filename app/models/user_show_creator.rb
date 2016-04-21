class UserShowCreator
  def initialize(user)
    shows = bit_service.shows(user)
    make_shows(shows, user)
  end

  def bit_service
    BitService.new
  end

  def make_shows(shows, user)
    shows.delete([])
    shows = shows.compact
    shows.map do |show|
      new_show = Show.find_or_create_by(
                    bit_id: show.first[:id].to_i,
                    datetime: show.first[:datetime].to_date,
                    formatted_datetime: show.first[:formatted_datetime],
                    formatted_location: show.first[:formatted_location],
                    ticket_url: show.first[:ticket_url],
                    facebook_rsvp_url: show.first[:facebook_rsvp_url],
                    venue_name: show.first[:venue][:name],
                    artist_name: show.first[:artists].first[:name],
                    venue_latitude: show.first[:venue][:latitude].to_f,
                    venue_longitude: show.first[:venue][:longitude].to_f,
                    )
      user.shows << new_show
    end
  end
end
