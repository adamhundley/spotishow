module SendLocation
  def send_location
    page.driver.post('/api/location', {lat: 39.7392, lng: -104.9903}, :format => 'json')
  end
end


RSpec.configure do |config|
  config.include SendLocation, type: :feature
end
