Rails.application.routes.draw do
  root "static_pages#landing"

  get "/auth/spotify", as: :spotify_login

  get "/auth/spotify/callback", to: "sessions#create"
  delete "/logout",             to: "sessions#destroy"

  namespace :account do
    resources :base, only: [:show]
    resources :playlists do
      resources :tracks, only: [:destroy]
    end
  end

end
