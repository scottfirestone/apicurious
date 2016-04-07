class Account::BaseController < ApplicationController
  before_action :current_user
  before_action :check_current_user

  def show
    @user = current_user
    @playlists = @user.playlists
  end

  def unfollow_playlist
    @user.unfollow_user_playlist
  end
end
