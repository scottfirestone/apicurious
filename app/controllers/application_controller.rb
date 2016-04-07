class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,
                :check_current_user

  def current_user
    @current_user ||= User.find_by(uid: session[:uid]) if session[:uid]
  end

  def check_current_user
    if @current_user == nil
      redirect_to root_path
    end
  end
end
