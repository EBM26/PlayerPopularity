Rails.application.routes.draw do
 
  root 'application#index'

  get '/runit' => 'application#runit'

  resources :application

  namespace :api do
    get '/players' => 'players#index'
    get '/players/:id' => 'players#show'

    get '/mentions' => 'mentions#index'
    get '/mentions/today' => 'mentions#today'
    get '/mentions/today/:hour' => 'mentions#hour'

  end

end
