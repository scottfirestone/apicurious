class PlaylistsController < ApplicationController
  before_action :current_user
  before_action :check_current_user

  def destroy
    current_user.unfollow_playlist(params[:id])
    redirect_to account_base_path(current_user)
  end
end
