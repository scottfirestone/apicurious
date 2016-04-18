class Playlist
  attr_reader :name,
              :ext_url,
              :images,
              :id,
              :owner,
              :public,
              :track_count,
              :track_href

  def initialize(params)
    @name = params[:name]
    @ext_url = params[:external_urls][:spotify]
    @images = playlist_image(params[:images]) unless params[:images].empty?
    @id = params[:id]
    @owner = params[:owner][:id]
    @public = params[:public]
    @track_count = params[:tracks][:total]
    @track_href = params[:tracks][:href]
  end

  def self.find(user, id)
    raw_playlist = SpotifyService.new.find_playlist(user, id)
    Playlist.new(raw_playlist)
  end

  def self.find_all_for_current_user(user)
binding.pry
    SpotifyService.new.current_user_playlists(user).map { |raw_playlist|
      Playlist.new(raw_playlist)
    }
  end

  def self.unfollow(user, playlist_id, playlist_owner)
    SpotifyService.new.unfollow_playlist(user, playlist_id, playlist_owner)
  end

  def self.create_new_playlist(user, playlist_name)
    SpotifyService.new.create_new_playlist(user, playlist_name)
  end

  def tracks(user, playlist_id)
    SpotifyService.new.playlist_tracks(user, playlist_id).map { |raw_track|
        PlaylistTrack.new(raw_track)
    }
  end

  private
    def playlist_image(images_params)
      images_params.first[:url]
    end
end
