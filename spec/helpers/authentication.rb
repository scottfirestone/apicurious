module Authentication
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      provider: "spotify",
      uid: "1234",
      info: {
        name: "Scott Firestone",
        screen_name: "mingusamongus",
        email: "scottfir@gmail.com",

        urls: {
          spotify: "www.example.com"
        },
        image: "https://robohash.org/#{("a".."z").to_a.shuffle.slice(0..5).join}"
      },
      credentials: {
        token: "token",
        refresh_token: "refreshtoken"
      }
    })
  end
end
