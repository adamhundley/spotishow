class Users::ShowsController < ApplicationController
  def index
    @shows = current_user.shows
  end
end
