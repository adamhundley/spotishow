module Api
  class Location::LocationController < ApiController
    def create
      if current_user
        current_user.update(latitude: params[:lat], longitude: params[:lng])
      else
        session[:latitude] = params[:lat]
        session[:longitude] = params[:lng]
      end
      head :no_content
    end

    def update
      current_user.update(location: params[:location])
      UserShowCreator.update_shows(current_user)
      render json: current_user.shows.count
    end
  end
end
