module Api
  class Artists::ArtistsController < ApiController
    def create
      find_artist(artist_name, current_user)
      render json: Artist.find_by(name: artist_name)
    end

    def destroy
      if current_user.shows.find_by(artist_id: artist_id) != nil
        show = current_user.shows.find_by(artist_id: artist_id)
        current_user.shows.delete(show.id)
        current_user.artists.delete(artist_id)
      else
        current_user.artists.delete(artist_id)
      end
      head :no_content
    end

    def show
      artist = Artist.find_by(name: artist_name)
      find_shows(artist)
      render json: artist.shows
    end

    private

      def find_shows(artist)
        ArtistShowsCreator.new(artist)
      end

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
