class SpotifyService
  def initialize
    @_apikey = ENV["SPOTIFY_CLIENT_ID"]
    @_secret = ENV["SPOTIFY_CLIENT_SECRET"]
    @_connection = Faraday.new("https://api.spotify.com/")
  end

  def top_artists(user)
    response = connection.get do |req|
      req.headers['Authorization'] = "Bearer #{user.token}"
      req.url 'v1/me/top/artists'
      req.params['limit'] = 50
      req.params['time_range'] = "long_term"
    end
      parse(response.body)[:items]
  end

private

  def connection
    @_connection
  end

  def apikey
    @_apikey
  end

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end

end
