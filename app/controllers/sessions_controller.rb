class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    user.update_token
    session[:uid] = user.uid
    redirect_to account_base_path(user.uid)
  end

  def destroy
    session.clear
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end
end
