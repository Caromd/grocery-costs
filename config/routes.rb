Rails.application.routes.draw do
  devise_for :users
  resources :prices
  resources :items
  resources :types
  resources :shopping_days

  root 'shopping_days#new'

  get 'items/index'
  get 'types/index'
  get 'summary' => 'shopping_days#summary'
  
end
