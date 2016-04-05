Rails.application.routes.draw do
  get 'users/show'

  root "static_pages#landing"

  get "/auth/spotify", as: :spotify_login


  get "/auth/spotify/callback", to: "sessions#create"
  delete "/logout",             to: "sessions#destroy"

  namespace :account do
    resources :base, only: [:show]
  end
end
