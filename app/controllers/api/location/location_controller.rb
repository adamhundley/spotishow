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
  end
end
