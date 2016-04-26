class BitService
  def initialize
    @_connection = Faraday.new(url: "http://api.bandsintown.com")
    connection.params['app_id'] = "making_the_band"
  end

  def shows(name)
    name = name.split.join('%20')
    parse(connection.get("/artists/#{name}/events.json?api_version=2.0"))
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
