Rails.application.routes.draw do
 get '/runit' => "application#runit"
 resources :application
end
