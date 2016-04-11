class Account::BaseController < ApplicationController
  before_action :require_correct_user

  def show
    @user = SpotifyUser.new(current_user)
    @playlists = @user.playlists
  end
  # 
  # def unfollow_playlist
  #   @user = SpotifyUser.new(current_user)
  #   @user.unfollow_playlist
  # end

  def require_correct_user
    render file: "/public/404" unless current_user == User.find_by(uid: params[:id])
  end
end
