class Account::Playlists::TracksController < Account::BaseController
  def destroy
    playlist_id = params[:playlist_id]
    user = SpotifyUser.new(current_user)
    response = user.remove_track_from_playlist(playlist_id, params[:uri])
    if response.success?
      flash[:success] = "Track removed from playlist!"
      redirect_to account_playlist_path(playlist_id)
    else
      flash[:error] = "There's been some sort of problem."
      redirect_to account_playlist_path(playlsit_id)
    end
  end
end
