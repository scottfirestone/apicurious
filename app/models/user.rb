class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    binding.pry
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

  def playlists
    SpotifyService.new.fetch_user_playlists(self)
  end

  def unfollow_playlist(playlist_id)
    SpotifyService.new.unfollow_playlist(self, playlist_id)
  end
end
