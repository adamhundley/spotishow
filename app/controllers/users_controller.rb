class UsersController < ApplicationController
  def show

  end

  def update
    User.find(params[:user_name]).update(location: params[:user][:location])
    redirect_to user_dashboard_path(current_user.uid)
  end
end
