Rails.application.routes.draw do
  devise_for :users
  resources :prices
  resources :items
  resources :types

  root 'prices#index'

  get 'items/index'
  get 'types/index'
  get 'summary' => 'prices#summary'
  
end
