class SpotifyUser < SimpleDelegator
  def initialize(user)
    @_user = user
    super(@_user)
  end

  def update_token
    new_token = SpotifyService.new.request_new_token(user)
    update_attribute(:token, new_token)
  end

  def create_new_playlist(playlist_name)
    Playlist.create_new_playlist(self, playlist_name)
  end

  def find_playlist(playlist_id)
    Playlist.find(self, playlist_id)
  end

  def playlists
    Playlist.find_all_for_current_user(self)
  end

  def unfollow_playlist(playlist_id, playlist_owner)
    Playlist.unfollow(self, playlist_id, playlist_owner)
  end

  def remove_track_from_playlist(playlist_id, track_uri)
    Playlist.remove_track(self, playlist_id, track_uri)
  end

  private

    def user
      @_user
    end
end
