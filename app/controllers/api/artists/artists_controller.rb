module Api
  class Artists::ArtistsController < ApiController

    def create
      find_artist(params[:name], current_user)
      render json: Artist.find_by(name: params[:name])
    end

    def destroy
      if !current_user.artists.find(params[:id]).shows.empty?
        current_user.artists.delete(params[:id])
        show = current_user.shows.find_by(artist_id: params[:id])
        current_user.shows.delete(show.id)
      else
        current_user.artists.delete(params[:id])
      end
      head :no_content
    end

    private

      def find_artist(name, user)
        UserArtistCreator.artist(name, user)
      end

      def artist_name
        params[:name]
      end

      def artist_id
        params[:id]
      end
  end
end
