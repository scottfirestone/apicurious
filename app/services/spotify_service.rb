class SpotifyService

  def connection
    Faraday.new(:url => 'https://api.spotify.com/v1/') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def user_playlists(user)
    response = connection.get do |req|
      req.url 'me/playlists'
      req.headers['Authorization'] = "Bearer #{user.token}"
    end

    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:items].map do |playlist|
      {
        :name => playlist[:name],
        :ext_url => playlist[:external_urls][:spotify],
        :images => playlist[:images].first[:url],
        :id => playlist[:id],
        :owner => playlist[:owner][:id],
        :public => playlist[:public],
        :tracks => playlist[:tracks]
      }
    end
  end

  def unfollow_playlist(user, playlist_id)
    a = connection.delete do |req|
      req.url "users/#{user.uid}/playlists/#{playlist_id}/followers"
      req.headers['Authorization'] = "Bearer #{user.token}"
    end
  end
end
