Rails.application.routes.draw do
 
  root 'players#index'

  get '/runit' => "application#runit"
  resources :application
end
