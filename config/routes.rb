Rails.application.routes.draw do
  get 'sessions/create'

  root "home#index"

  get "/auth/spotify", as: :spotify_login
  get "/auth/spotify/callback", to: "sessions#create"
  delete "/logout",             to: "sessions#destroy"
end
