class SpotifyService

  def connection
    Faraday.new(:url => 'https://api.spotify.com/v1/') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def fetch_user_playlists(user)
    response = connection.get do |req|
      req.url 'me/playlists'
      req.headers['Authorization'] = "Bearer #{user.token}"
    end

    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:items].map { |params|
      Playlist.new(params)
    }
  end

  def unfollow_playlist(user, playlist_id)
    a = connection.delete do |req|
      req.url "users/#{user.uid}/playlists/#{playlist_id}/followers"
      req.headers['Authorization'] = "Bearer #{user.token}"
    end
  end
end
