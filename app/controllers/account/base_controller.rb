class Account::BaseController < ApplicationController
  before_action :require_correct_user

  def show
    @user = SpotifyUser.new(current_user)
    @playlists = @user.playlists
  end

  def require_correct_user
    render file: "/public/404" unless current_user
  end
end
