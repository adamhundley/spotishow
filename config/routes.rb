Rails.application.routes.draw do
  get 'sessions/create'

  root "home#index"

  namespace :api, defaults: {format: :json} do
    resources :artists, only: [:show, :create, :destroy], module: "artists", param: :name
    resources :location, only: [:create, :update], module: "location"
  end

  namespace :users, path: ":user_name", as: :user do
    get "/dashboard", action: "show", as: :dashboard
    get "/artists", to: "artists#index", as: :artists
    get "/shows", to: "shows#index", as: :shows
  end

  get "/auth/spotify", as: :spotify_login
  get "/auth/spotify/callback", to: "sessions#create"
  delete "/logout",             to: "sessions#destroy"
end
