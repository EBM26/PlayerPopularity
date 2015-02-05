Rails.application.routes.draw do
 
  root 'application#index'

  get '/runit' => 'application#runit'

  resources :application

  namespace :api do
    get '/players' => 'players#index'
    get '/players/current_scores' => 'players#current_scores'
    get '/players/:id' => 'players#show'

    get '/mentions' => 'mentions#index'
    get '/mentions/today' => 'mentions#today'
    get '/mentions/today/:hour' => 'mentions#hour'

  end

end
