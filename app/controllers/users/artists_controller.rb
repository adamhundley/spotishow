class Users::ArtistsController < ApplicationController
  def index
    @artists = current_user.artists
  end

  def create
    user = current_user
    UserArtistCreator.artist(artist_name, user)
    head :no_content
  end

  def destroy
    if !current_user.artists.find(artist_id).shows.empty?
      current_user.artists.delete(artist_id)
      show = current_user.shows.find_by(artist_id: artist_id)
      current_user.shows.delete(show.id)
    else
      current_user.artists.delete(artist_id)
    end
    head :no_content
  end

  private

    def artist_name
      params[:name]
    end

    def artist_id
      params[:id]
    end
end
