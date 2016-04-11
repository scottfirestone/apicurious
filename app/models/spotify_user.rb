class SpotifyUser < SimpleDelegator
  def initialize(user)
    @_user = user
    super(@_user)
  end

  def update_token
    new_token = SpotifyService.new.request_new_token(user)
    update_attribute(:token, new_token)
  end

  def playlists
    Playlist.find_all_for_current_user(self)
  end

  def unfollow_playlist(playlist_id, playlist_owner)
    Playlist.unfollow(self, playlist_id, playlist_owner)
  end

  private

    def user
      @_user
    end
end
