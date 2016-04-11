class PlaylistsController < ApplicationController
  def destroy
    user = SpotifyUser.new(current_user)
    playlist_id = params[:id].split('/', 2)[0]
    playlist_owner = params[:id].split('/', 2)[1]
    user.unfollow_playlist(playlist_id, playlist_owner)
    flash[:success] = "Playlist successfully unfollowed."
    redirect_to account_base_path(current_user.uid)
  end
end
