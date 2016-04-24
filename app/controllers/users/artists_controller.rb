class Users::ArtistsController < ApplicationController
  def index
    @artists = current_user.artists
  end

  def destroy
    current_user.artists.delete(params[:id])
    head :no_content
  end
end
