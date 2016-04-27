class UserShowCreator
  attr_reader :artist

  def initialize(artist, user)
    @artist = artist
    name = @artist.name
    show = bit_service.show(name, user)
    return if show.nil? || show.empty?
    make_show(show, user)
  end

  def bit_service
    BitService.new
  end

  def self.update_shows(user)
    user.shows = []
    user.artists.each do |artist|
      UserShowCreator.new(artist, user)
    end
  end

  def make_show(show, user)
      new_show = Show.find_or_create_by(
                    bit_id: show.first[:id].to_i,
                    title: show.first[:title],
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
      artist.shows << new_show
      user.shows << new_show
  end
end
