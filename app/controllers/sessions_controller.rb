class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:uid] = user.uid
    redirect_to root_path
  end
end
