class SpotifyService
  require "base64"
  attr_reader :playlist

  def initialize
    @_apikey = ENV["SPOTIFY_CLIENT_ID"]
    @_secret = ENV["SPOTIFY_CLIENT_SECRET"]
    @_connection = Faraday.new("https://api.spotify.com/")
  end

  def current_user_playlists(user)
    response = connection.get do |req|
      req.url 'v1/me/playlists'
      req.headers['Authorization'] = "Bearer #{user.token}"
    end
    parse(response)[:items]
  end

  def unfollow_playlist(user, playlist_id, playlist_owner)
    response = connection.delete do |req|
      req.headers['Authorization'] = "Bearer #{user.token}"
      req.url "v1/users/#{playlist_owner}/playlists/#{playlist_id}/followers/"
    end
    binding.pry
  end

  def request_new_token(user)
    hash = { grant_type: "refresh_token", refresh_token: user.refresh_token}
    encoded_auth = Base64.strict_encode64("#{@_apikey}:#{@_secret}")
    response = Faraday.new("https://accounts.spotify.com/api/token").post do |req|
      req.headers['Authorization'] = "Basic #{encoded_auth}"
      req.body = hash
    end
    parse(response)[:access_token]
  end

  private
    def apikey
      @_apikey
    end

    def connection
      @_connection
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
