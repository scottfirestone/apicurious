class Account::PlaylistsController < Account::BaseController

  def new
  end

  def create
    user = SpotifyUser.new(current_user)
    playlist_name = params["name"]
    playlist = user.create_new_playlist(playlist_name)
    if response.status == 200
      flash[:success] = "#{playlist_name} has been created!"
      redirect_to account_playlist_path(playlist.id)
    else
      flash.now[:errors] = "There was a problem creating playlist: #{playlist_name}"
      render :new
    end
  end

  def show
    user = SpotifyUser.new(current_user)
    @playlist = user.find_playlist(params[:id])
    @playlist_tracks = @playlist.tracks(user, @playlist.id)

  end

  def edit
    user = SpotifyUser.new(current_user)
    @playlist = user.find_playlist(params[:id])
  end

  def update
  end

  def destroy
    user = SpotifyUser.new(current_user)
    playlist_id = params[:id].split('/', 2)[0]
    playlist_owner = params[:id].split('/', 2)[1]
    user.unfollow_playlist(playlist_id, playlist_owner)
    flash[:success] = "Playlist successfully unfollowed."
    redirect_to account_base_path(current_user.uid)
  end
end
