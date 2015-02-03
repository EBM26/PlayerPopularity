Rails.application.routes.draw do
 
  root 'application#index'

  get '/runit' => 'application#runit'

  resources :application

  namespace :api do
    get '/players' => 'players#index'
    get '/players/:id' => 'players#show'

    get '/total_mentions' => 'total_mentions#index'
    get '/total_mentions/:hour' => 'total_mentions#hour'
  end

end
