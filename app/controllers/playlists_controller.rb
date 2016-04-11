class PlaylistsController < ApplicationController
  def destroy
    current_user.unfollow_playlist(params[:id])
    flash[:success] = "Playlist successfully unfollowed."
    redirect_to account_base_path(current_user.uid)
  end
end
