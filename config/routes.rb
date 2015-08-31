Rails.application.routes.draw do
  resources :users
  resources :events

  root to: 'pages#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/vk_signin' => 'sessions#vkontakte', :as => :vk_signin
  get '/fb_signin' => 'sessions#facebook', :as => :fb_signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
