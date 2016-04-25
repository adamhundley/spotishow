class Users::ArtistsController < ApplicationController
  def index
    @artists = current_user.artists
  end

  def destroy
    current_user.artists.delete(params[:id])
    show = current_user.shows.find_by(artist_id: params[:id])
    current_user.shows.delete(show.id)
    head :no_content
  end
end
