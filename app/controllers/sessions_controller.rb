class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"], location)
    user.update_token
    session[:uid] = user.uid
    redirect_to user_dashboard_path(current_user.uid)
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

    def location
      {latitude: session[:latitude], longitude: session[:longitude]}
    end
end
