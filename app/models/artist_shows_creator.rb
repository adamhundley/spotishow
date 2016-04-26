class ArtistShowsCreator
  attr_reader :artist

  def initialize(artist)
    @artist = artist
    name = @artist.name
    shows = bit_service.shows(name)
    return if shows.nil? || shows.empty?
    make_shows(shows)
  end

  def bit_service
    BitService.new
  end

  def make_shows(shows)
    shows.each do |show|
      make_show(show)
    end
  end

  def make_show(show)
      new_show = Show.find_or_create_by(
                    bit_id: show[:id].to_i,
                    title: show[:title],
                    datetime: show[:datetime].to_date,
                    formatted_datetime: show[:formatted_datetime],
                    formatted_location: show[:formatted_location],
                    ticket_url: show[:ticket_url],
                    facebook_rsvp_url: show[:facebook_rsvp_url],
                    venue_name: show[:venue][:name],
                    artist_name: show[:artists].first[:name],
                    venue_latitude: show[:venue][:latitude].to_f,
                    venue_longitude: show[:venue][:longitude].to_f,
                    )
      artist.shows << new_show
  end
end
