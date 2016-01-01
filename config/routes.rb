Rails.application.routes.draw do
  devise_for :users
  resources :prices
  resources :items
  resources :types
  resources :shopping_days

  root 'pages#home'

  get 'items/index'
  get 'types/index'
  get 'summary' => 'shopping_days#summary'
  
  get '/home' => 'pages#home'
  
end
