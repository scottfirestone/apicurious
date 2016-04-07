class User < ActiveRecord::Base
  validates :uid, uniqueness: true

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid           = auth_info.uid
      new_user.name          = auth_info[:info][:name]
      new_user.nickname      = auth_info[:info][:nickname]
      new_user.email         = auth_info[:info][:email]
      new_user.spotify       = auth_info[:info][:urls][:spotify]
      new_user.image         = auth_info[:info][:image]
      new_user.token         = auth_info[:credentials][:token]
      new_user.refresh_token = auth_info[:credentials][:refresh_token]
    end
  end

  def update_token
    new_token = SpotifyService.new.request_new_token(self)
    update_attribute(:token, new_token)
  end

  def playlists
    SpotifyService.new.fetch_user_playlists(token)
  end

  def unfollow_playlist(playlist_id)
    SpotifyService.new.unfollow_playlist(self, playlist_id)
  end
end
