# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'support/wait_for_ajax'
require 'support/stub_omniauth'
require 'support/send_location'
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
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
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
