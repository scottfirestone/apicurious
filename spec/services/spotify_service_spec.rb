require "rails_helper"

describe SpotifyService do
  context "#userinfo" do
    it "returns spotify user info" do
      VCR.use_cassette("spotify_service#user_info") do
        service = SpotifyService.new
        denver_coordinates = { lat: 39.849312, long: -104.673828 }

        weather = service.weather(denver_coordinates)

        expect(weather[:timezone]).to eq("America/Denver")
        expect(weather[:currently][:summary]).to eq("Partly Cloudy")
        expect(weather[:minutely][:icon]).to eq("partly-cloudy-day")
      end
    end
  end
end
