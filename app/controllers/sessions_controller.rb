class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:uid] = user.uid
    flash[:success] = "Welcome to Spotishow, #{current_user.name}!"
    redirect_to user_dashboard_path(current_user.uid)
  end

  def destroy
    flash[:success] = "Sad to see you go #{current_user.name}. Come back again soon!"
    session.clear
    redirect_to root_path
  end
end
