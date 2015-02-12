Rails.application.routes.draw do
 
  root 'application#index'

  get '/runit' => 'application#runit'

  resources :application
  resources :players

  namespace :api do
    get '/players' => 'players#index'
    get '/players/current_scores' => 'players#current_scores'
    get '/players/hourly_scores' => 'players#hourly_scores'
    get '/players/top_five' => 'players#top_five'
    get '/players/:id' => 'players#show'

    get '/mentions' => 'mentions#index'
    get '/mentions/today' => 'mentions#today'
    get '/mentions/today/:hour' => 'mentions#hour'

  end

end
