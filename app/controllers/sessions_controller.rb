class SessionsController < ApplicationController
  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:uid] = user.uid
    end
    user.get_new_token
    redirect_to account_base_path(user)
  end

  def destroy
    session.delete(:uid)
    @current_user = nil
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
  end
end
