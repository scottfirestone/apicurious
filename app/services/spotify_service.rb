class SpotifyService
  require "base64"

  def connection
    Faraday.new(:url => 'https://api.spotify.com/v1/') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def fetch_user_playlists(user_token)
    response = connection.get do |req|
      req.url 'me/playlists'
      req.headers['Authorization'] = "Bearer #{user_token}"
    end

    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:items].map { |params|
      Playlist.new(params)
    }
  end

  def unfollow_playlist(user, playlist_id)
    connection.delete do |req|
      req.url "users/#{user.uid}/playlists/#{playlist_id}/followers"
      req.headers['Authorization'] = "Bearer #{user.token}"
    end
  end

  def request_new_token(user)
    hash = { grant_type: "refresh_token", refresh_token: user.refresh_token}
    encoded_auth = Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT_ID']}:#{ENV['SPOTIFY_CLIENT_SECRET']}")

    response = Faraday.new("https://accounts.spotify.com/api/token").post do |req|
      req.headers['Authorization'] = "Basic #{encoded_auth}"
      req.body = hash
    end
    a = JSON.parse(response.body, symbolize_names: true)[:access_token]
  end
end
