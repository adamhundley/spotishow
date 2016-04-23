# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

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
end

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
      token: "BQBX-jRP3gJsQgI9lBWyFcySebE7CcdK-A2Eu68ku8-L5iLJZpoScBQyk-y6DrIEj0cBBG_S1BmmrceLMKPM0V7wfUP-GZdALI0UgrZriJ_RE6TN1dykXEqtGHB2Vcg0_eR7PLeBhyFmSSasl0cToHLr",
      refresh_token: 1461029417
    },
    extra: {
      raw_info: {
        href: "https://api.spotify.com/v1/users/adamhundley"
      }
    }
  })
end
