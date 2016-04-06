class SpotifyService

  def connection
    Faraday.new(:url => 'https://api.spotify.com/v1/') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def user_playlists(user)
    response_body = connection.get do |req|
      req.url 'me/playlists'
      req.headers['Authorization'] = "Bearer #{user.token}"
    end.body

    parsed = JSON.parse(response_body, symbolize_names: true)
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
end
