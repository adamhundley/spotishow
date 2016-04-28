# Spotishow
[![Code Climate](https://codeclimate.com/github/adamhundley/spotishow/badges/gpa.svg)](https://codeclimate.com/github/adamhundley/spotishow) [![Test Coverage](https://codeclimate.com/github/adamhundley/spotishow/badges/coverage.svg)](https://codeclimate.com/github/adamhundley/spotishow/coverage)

[Spotishow](https://spotishow.herokuapp.com) is a Full Stack Ruby on Rails application that scans your Spotify account and populates a list of shows based on your location and most listened to artists. You have the ability to remove and add artists to your Spotishow account, which then updates your list of shows. You can also update your location which affects your show list.

Spotishow was created for my Turing School of Software Design [self directed project](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/self_directed_project.md).

#### User Workflow
 ![user workflow]()

#### Technologies Used:
  * Full stack Ruby on Rails
  * JavaScript
  * jQuery
  * AJAX
  * HTML5
  * CSS
  * Bootstrap
  * Spotify API
  * Bandsintown API
  * Testing with Rspec and Capybara/Selinium

#### For local use:
```
git clone git@github.com:adamhundley/spotishow.git
cd spotishow
bundle
rails s
```
* Navigate to `localhost:3000/` on your browser

#### Test Suite
* In order to run the test suite there are a few things you need to do:
  * Run `figaro install` from your command line
  * This creates your `application.yml`
  * Sign up for an API key on [Spotify](https://developer.spotify.com)
  * create `SPOTIFY_CLIENT_ID` in `application.yml` and assign it to value from Spotify
  * create `SPOTIFY_CLIENT_SECRET` in `application.yml` and assign it to value from Spotify
  * Get a valid token from [Spotify](https://developer.spotify.com/web-api/console/get-current-user-top-artists-and-tracks/)
  * create `SPOTIFY_TOKEN` in `application.yml` and assign it to value from Spotify
* `rm -rf spec/cassettes` to make sure VCR cassettes are clear
* run `rspec` from the command line to run the full suite

Please contact [me](mailto:adamhundley@gmail.com) with any questions. Thanks!
