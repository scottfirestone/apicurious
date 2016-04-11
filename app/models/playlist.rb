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
    @images = params[:images].first[:url]
    @id = params[:id]
    @owner = params[:owner][:id]
    @public = params[:public]
    @track_count = params[:tracks][:total]
    @track_href = params[:tracks][:href]
  end

  def self.find(id)
    service.current_user_playlist()
  end

  def self.find_all_for_current_user(user)
    SpotifyService.new.current_user_playlists(user).map { |raw_playlist|
      Playlist.new(raw_playlist)
    }
  end

  def self.unfollow(user, playlist_id, playlist_owner)
    SpotifyService.new.unfollow_playlist(user, playlist_id, playlist_owner)
  end
end
