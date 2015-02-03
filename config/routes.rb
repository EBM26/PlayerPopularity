Rails.application.routes.draw do
 
  root 'application#index'

  get '/runit' => "application#runit"

  resources :application

  namespace :api do
    resources :players
    resources :total_mentions
  end

end
