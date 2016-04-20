class Users::ArtistsController < ApplicationController
  def index
    @artists = current_user.artists
  end
end
