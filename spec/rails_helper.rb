# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'support/wait_for_ajax'
require 'billy/rspec'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end


  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end


  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end


  config.before(:each) do
    DatabaseCleaner.start
  end


  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

Capybara.javascript_driver = :selenium_chrome_billy

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true
end

Billy.configure do |c|
  c.cache = true
  c.ignore_params = ["http://api.bandsintown.com/artists/John%20Mayer/events/search.json?api_version=2.0&app_id=making_the_band&location=39.7496256,-105.0002111&radius=50", "http://api.bandsintown.com/artists/John%20Mayer/events/search.json?api_version=2.0&app_id=making_the_band&location=39.7392,%20-104.9903&radius=50","http://api.bandsintown.com/artists/John%20Mayer/events/search.json?api_version=2.0&app_id=making_the_band&location=39.7496388,-105.00019859999999&radius=50", "http://api.bandsintown.com/artists/John%20Mayer/events/search.json?api_version=2.0&app_id=making_the_band&location=39.7392,%20-104.9903&radius=50", "http://api.bandsintown.com/artists/John%20Mayer/events/search.json?api_version=2.0&app_id=making_the_band&location=39.7496388,-105.00019859999999&radius=50"]
  c.persist_cache = true
  c.cache_path = 'spec/req_cache/'
end

Billy.proxy.reset_cache

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
    provider: "spotify",
    uid: "adamhundley",
    info: {
      name: "Adam Hundley",
      screen_name: "adamhundley",
      email: "adamhundley@gmail.com",

      urls: {
        spotify: "https://open.spotify.com/user/adamhundley"
      },
      image: "https://scontent.xx.fbcdn.net/hprofile-xfp1/v/t1.0-1/p200x200/12049656_10100204503401754_3715087154579945830_n.jpg?oh=f7d96813ab87b164df6f41f4265d7d7b&oe=57B548E1"
    },
    credentials: {
      token: "BQDAVYmHRKmwk4kSjhaW8xcH8wzuqhP3yN5gJFlo31Azspz17G8bg7zYyV0EvLOPz-zHd9LqaHjB6kGUbULgW-mJcM1HaMvfLAqYn2TW3L63O5ME8qqg1APmKmb6oo9ybpGacqkE6ryBL446kIIp-stgjlbPBUErx7QbsIGK2-OUJsIB5tbCyHlE6OxFEIZF5BW_FIT6AXSskD1WI-iZsWi-wptCSkbMW_hdUxrhrByMwNn8IPC6K1o-I6vN4jCscCmB3f1EjTEgrq3XznjWtTzoSqfbc8GTx9v-g0SDWgOCATsgE5IFMDft",
      refresh_token: "BQDVB0pazKW5KGtGiVl3H64u3DcJNwZIJDVu3mQsSxozaOwj36KrbvaZcxSDdBoJ_HyXd8CtXCTX8JeyJ9DF10odHzc_BM4aO7JXTn2kl0uewZBvOFYzkU4yFRswG6__jKHBmcTN1PzJsxe0UJ9CmQGH3i_DS2qHWP-qiW1VHSTlQy2bj7CvXwmWxArWIz1ggH_gD6D7epkohIwKGQxKXXrEuUBJ-1_8kHttnVEUSViC93YOZ6XgHqhbGMcafHPLbRawkpdySSYFaDifqgLhawsFCUulHOdMIjS6S8PnZlWth0IR1bhhYHbt",
      token_expire: 20160923
    },
    extra: {
      raw_info: {
        href: "https://api.spotify.com/v1/users/adamhundley"
      }
    }
  })
end

def send_location
  page.driver.post('/api/location', {lat: 39.7392, lng: -104.9903}, :format => 'json')
end
