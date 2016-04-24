Rails.application.routes.draw do
  get 'sessions/create'

  root "home#index"

  namespace :api, defaults: {format: :json} do
    post '/location', to: "api#location"
    get '/shows', to: "api#index"
  end

  namespace :users, path: ":user_name", as: :user do
    get "/dashboard", action: "show", as: :dashboard
    get "/artists", to: "artists#index", as: :artists
    delete "/artists", to: "artists#destroy", as: :artists_delete
    get "/shows", to: "shows#index", as: :shows
    patch "/", action: "update", params: :id
  end

  get "/auth/spotify", as: :spotify_login
  get "/auth/spotify/callback", to: "sessions#create"
  delete "/logout",             to: "sessions#destroy"
end
