class SpotifyService
  require "base64"
  attr_reader :playlist

  def initialize
    @_apikey = ENV["SPOTIFY_CLIENT_ID"]
    @_secret = ENV["SPOTIFY_CLIENT_SECRET"]
    @_connection = Faraday.new("https://api.spotify.com/v1")
  end

  def current_user_playlists(user)
    response = connection.get do |req|
      req.url 'me/playlists'
      req.headers['Authorization'] = "Bearer #{user.token}"
    end
    parse(response)[:items]
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
# require "base64"
#
#   def initialize
#
#   end
#
#   def connection
#     Faraday.new(:url => 'https://api.spotify.com/v1') do |faraday|
#       faraday.request  :url_encoded
#       faraday.response :logger
#       faraday.adapter  Faraday.default_adapter
#     end
#   end
#
#   def fetch_user_playlists(user_token)
#     response = connection.get do |req|
#       req.url 'me/playlists'
#       req.headers['Authorization'] = "Bearer #{user_token}"
#     end
#
#     parsed = JSON.parse(response.body, symbolize_names: true)
#     parsed[:items].map { |params|
#       Playlist.new(params)
#     }
#   end
#
#   def unfollow_playlist(user, playlist_id)
#     connection.delete do |req|
#       req.url "/users/#{user.uid}/playlists/#{playlist_id}/followers"
#       req.headers['Authorization'] = "Bearer #{user.token}"
#     end
#   end
# end
