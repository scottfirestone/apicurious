require "rails_helper"

describe SpotifyService do
  context "#userinfo" do
    it "returns spotify user info" do
      VCR.use_cassette("spotify_service#user_playlists") do
        service = SpotifyService.new

        user = SpotifyUser.new(User.create(token: ENV["USER_TOKEN"]))

        playlists = service.current_user_playlists(user)

        expect(weather[:timezone]).to eq("America/Denver")
        expect(weather[:currently][:summary]).to eq("Partly Cloudy")
        expect(weather[:minutely][:icon]).to eq("partly-cloudy-day")
      end
    end
  end
end
