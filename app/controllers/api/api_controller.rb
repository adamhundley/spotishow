module Api
  class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json

    def location
      # session[:latitude] = params[:lat]
      # session[:longitude] = params[:lng]
      current_user.update(latitude: params[:lat], longitude: params[:lng])
      head :no_content
    end
  end
end
