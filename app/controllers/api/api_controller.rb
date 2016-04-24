module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json

    def location
      if current_user
        current_user.update(latitude: params[:lat], longitude: params[:lng])
        current_user.shows = []
        UserShowCreator.new(current_user)
      else
        session[:latitude] = params[:lat]
        session[:longitude] = params[:lng]
      end
      head :no_content
    end
  end

  def index

  end
end
