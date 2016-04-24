class BitService
  def initialize
    @_connection = Faraday.new(url: "http://api.bandsintown.com")
    connection.params['app_id'] = "making_the_band"
  end

# http://api.bandsintown.com/artists/Skrillex/events/search.json?api_version=2.0&app_id=YOUR_APP_ID&location=San+Diego,CA&radius=10
  # def artist(name)
  #   name = name.split.join('%20')
  #   parse(connection.get("/artists/#{name}/events/.json?api_version=2.0"))
  # end
  def shows(user)
    user.artists.map do |artist|
      show(artist.name, user)
    end
  end

  def show(name, user)
    if name.ascii_only?
      name = name.split.join('%20')
      location = location(user)
      parse(connection.get("/artists/#{name}/events/search.json?api_version=2.0&location=#{location}&radius=50"))
    end
  end

private

  def location(user)
    if user.latitude != nil
      "#{user.latitude},#{user.longitude}"
    else
      "39.7392, -104.9903"
    end
  end

  def connection
    @_connection
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
