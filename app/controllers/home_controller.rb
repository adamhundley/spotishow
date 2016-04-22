class HomeController < ApplicationController
  def index
    if current_user
      redirect_to user_dashboard_path(current_user.uid)
    end
  end
end
